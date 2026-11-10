#include "serialservice.h"

SerialService::SerialService() {}

QVariantList SerialService::getNormalPort(){
    /* 创建一个串口对象 */
    serialPort = new QSerialPort(this);
    /* 搜索所有可用串口 */
    QVariantList list;
    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts()) {
        QSerialPort serial;
        serial.setPort(info);
        if (serial.open(QIODevice::ReadWrite)){
            qDebug()<<"==>"<<serial.portName();
            list.append(serial.portName());
        }
    }
    return list;
}

int SerialService::openPort(const QVariant portName,const QVariant rate,const QVariant status){
    int ret=0;
    QString port = portName.toString();
    int rateInt = rate.toInt();
    bool isOpen = status.toBool();

    qDebug() << "port:"<<port;
    qDebug() << "rateInt:"<<rateInt;
    qDebug() << "isOpen:"<<isOpen;

    if(isOpen)
    {
        /* 串口设置 */
        serialPort->setPortName(port);
        serialPort->setBaudRate(rateInt);
        serialPort->setDataBits(QSerialPort::Data8);
        serialPort->setStopBits(QSerialPort::OneStop);
        serialPort->setParity(QSerialPort::NoParity);

        /* 打开串口提示框 */
        if (true == serialPort->open(QIODevice::ReadWrite))
        {
            qDebug() << "串口打开成功";
            connect(serialPort, &QSerialPort::readyRead, this, &SerialService::DataReceived);
        }
        else
        {
            qDebug() << "串口打开失败";
            ret=-1;
        }
    }else{
        serialPort->close();
        qDebug() << "串口关闭成功";
    }
    return ret;
}

QVariant SerialService::sendAndReceiveMsg(const QVariant Msg){
    QString send_str=Msg.toString();
    qDebug() <<  "开始发送测试数据: " <<  send_str;
    // serialPort->write(send_str.toUtf8());
    // // 读取数据
    // QString inputData;
    // while(serialPort->waitForReadyRead(1000)) {
    //     inputData += serialPort->readAll();
    //     //QString inputData = serialPort->read(100);
    // }
    // qDebug() << "Received Data : " << inputData.size();
    // QString recv_str="接收测试数据:"+inputData;
    // QVariant res = QVariant::fromValue(recv_str);
    SendHexData(send_str.toUtf8().constData());
    QString res = "ok";
    return res;
}

void SerialService::DataReceived(){
    QString inputData;
    QByteArray tmpBy= serialPort->readAll();
    //qDebug() << "DataReceived recv data:" << tmpBy;
    foreach (char bytestr, tmpBy) {
        //qDebug() << "==>" << bytestr;
        int tmpint = (int)bytestr;
        if ((tmpint < 32)||(tmpint==127)){
            QString hexStr = intToHexString(tmpint);
            inputData += hexStr;
        }else{
            inputData += bytestr;
            //qDebug() << "Received Data : " << tmpstr;
        }
    }
    qDebug() << "inputData Data [" << inputData << "]";
    //在这里把数据推送到界面展示

    //ui->listWidget->addItem(inputData);
    emit putReceviceData(QVariant::fromValue(inputData));
}

void SerialService::sendToLp(const QVariant portName){
    // 创建一个 QProcess 对象
    QProcess process;
    QString devport=portName.toString();
    qDebug() << __FUNCTION__ <<__LINE__<< devport;
    // 设置要执行的命令和参数
    QStringList arguments;
    //arguments << "-c" << "date > /home/ha.txt"; // 将命令和参数放入列表中
    //arguments << "-c" << "date > "+devport; // 将命令和参数放入列表中
    arguments << "-c" << "cat /opt/ymore/bin/tools/TestLp.txt > "+devport; // 将命令和参数放入列表中
    qDebug() <<  __LINE__<< arguments;

    // 启动后台命令
    process.start("sh", arguments); // 使用 sh 启动命令，并传递参数列表

    // 等待命令执行完成
    process.waitForFinished();
}

QVariant SerialService::ping(const QVariant ip){
    qDebug() << ip;
    // 创建QProcess实例
    QProcess pingProcess;
    // 设置要执行的命令
    QString command("ping");
    // 设置参数，这里以ping百度为例
    QStringList arguments;
    QByteArray result;
    arguments << "-c" << "1" << ip.toString(); // 假设ip.toString()返回的是"www.baidu.com"

    // 开始执行ping命令
    pingProcess.start(command, arguments);
    // 等待命令执行完成
    if (!pingProcess.waitForFinished()) {
        qDebug() << "Ping failed:" << pingProcess.errorString();
    } else {
        // 读取输出结果
        result = pingProcess.readAll();
        // 打印结果
        qDebug() << "result" << result;
    }
    return QVariant::fromValue(result);
}


void SerialService::SendHexData(const char* sendbuf){
    QByteArray sendData;
    int len=strlen(sendbuf);
    for (int i=0;i<len;i++)
    {
        bool bfind=false;
        unsigned int hexValue=0;
        //std::cout << i << ":" << sendbuf[i] << std::endl;
        if(sendbuf[i]=='<'){
            //检测是否是特殊组合符号
            if((i+SP_LEN<=len) && (sendbuf[i+SP_LEN]=='>')){
                char substr[SP_LEN]={0}; // 用于存储截取后的子串
                strncpy(substr, sendbuf + i+1, 2);
                // 字符串转整形的方式----使用 sscanf 函数进行转换
                std::sscanf(substr, "%x", &hexValue); // 将字符串按十六进制格式解析并存储到 hexValue 中
                //std::cout << "Hex value: 0x" << std::hex << hexValue << std::endl;
                //std::cout << "value: "<< hexValue << std::endl;
                //只对小于32的特殊字符进行特殊转换
                if(hexValue<32){
                    i = i+SP_LEN;
                    bfind = true;
                }
            }
        }
        if(false==bfind){
            hexValue=(int)sendbuf[i];//字符转整形的方式--直接转型
        }

        //std::cout << "Hex value: 0x" << std::hex << hexValue << std::endl;
        sendData.append(static_cast<char>(hexValue));
        // 打印转换后的字节数据
        //qDebug() << "Byte data:" << sendData.toHex().constData();
    }
    serialPort->write(sendData);
}

QString SerialService::intToHexString(int value) {
    std::stringstream stream;
    stream << std::hex << value;
    std::string tmpstr = "<" + stream.str() + ">";
    //std::cout << "十六进制字符串: " << stream.str() << std::endl;
    QString qStr = QString::fromStdString(tmpstr);
    return qStr;
}

QString SerialService::recvserialdata(){
    QString inputData;
    while(serialPort->waitForReadyRead(1000)) {
        QString tmpstr = serialPort->read(2);
        QByteArray ba = tmpstr.toLatin1(); // Assume only contains ASCII characters
        char* cstr = ba.data();
        int tmpint = (int)cstr[0];
        if (tmpint < 32){
            QString hexStr = intToHexString(tmpint);
            inputData += hexStr;
        }else{
            inputData += tmpstr;
            //qDebug() << "Received Data : " << tmpstr;
        }
    }
    //QString recv_str="接收测试数据:"+inputData;
    // QString recv_str="接收测试数据:"+inputData;

    qDebug() << "Received Data : " << inputData;
    return inputData;
}


QVariant SerialService::checkvboxstatus(){
    bool virtualstatus=true;
    return QVariant(virtualstatus);  // 返回一个 QVariant 封装的 bool
}
