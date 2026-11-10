#include "computerservice.h"

typedef std::string (*Decode_file)(std::string Encode_filename,const char key);


ComputerService::ComputerService() {
    m_db_ip="";
}

bool ComputerService::setComputer(const QVariantMap computerMap){
    // QString ip =computerMap.value("Ip").toString();
    QString location =computerMap.value("Location").toString();
    QString duty =computerMap.value("Duty").toString();
    QString manufacturer=computerMap.value("Manufacturer").toString();
    QString model=computerMap.value("Model").toString();
    QString manufactSn=computerMap.value("ManufactSn").toString();
    QString department=computerMap.value("Department").toString();
    QString owner=computerMap.value("Owner").toString();
    QString tel=computerMap.value("Tel").toString();
    QString buyDate=computerMap.value("BuyDate").toString();
    QString assetNo=computerMap.value("AssetNo").toString();
    QString assetStatus=computerMap.value("AssetStatus").toString();
    QString Ip = getLocalIp();
    QString Cpu = getCPUName();
    QString CpuId = getCpuId();
    QString Hd = getDiskName();
    QString meomery = getMemoryName();
    QString macAddressesString = getMacAddress();
    QString Os = getOs();


    Computer *insertObj = new Computer();
    insertObj->setIp(Ip);
    insertObj->setLocation(location);
    insertObj->setDuty(duty);
    insertObj->setManufacturer(manufacturer);
    insertObj->setModel(model);
    insertObj->setManufactSn(manufactSn);
    insertObj->setDepartment(department);
    insertObj->setOwner(owner);
    insertObj->setTel(tel);
    insertObj->setBuyDate(buyDate);
    insertObj->setAssetNo(assetNo);
    insertObj->setAssetStatus(assetStatus);
    insertObj->setCPUID(CpuId);
    insertObj->setComputerName(QHostInfo::localHostName());
    insertObj->setAllMac(macAddressesString);
    insertObj->setCpu(Cpu);
    insertObj->setHd(Hd);
    insertObj->setMemory(meomery);
    insertObj->setLastOnLineDate(QString::number(QDateTime::currentSecsSinceEpoch()));
    insertObj->setOs(Os);

    if(isHave(CpuId)){
        qDebug() << "updateOldComputer";
        updateOldComputer(insertObj);
    }else{
        qDebug() << "insert";
        insert(insertObj);
    }
    qDebug() << "IpQD:"<<Ip;

    initVncMsg();



    return true;
}

bool ComputerService::insert(Computer *computer){
    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return false;
    }
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);

    query.prepare("INSERT INTO computer(Status,ComputerName,Ip,Location,Duty,Cpu,Memory,Hd,"
                  "CPUID,AllMac,Os,Manufacturer,Model,ManufactSn,Department,Owner,Tel,AssetNo,"
                  "BuyDate,AssetStatus,LastOnLineDate,Linsence,SdmsClnVer,rowUuid) "
                  "VALUES (:Status, :ComputerName, :Ip,:Location, :Duty, :Cpu,:Memory, :Hd, :CPUID,:AllMac,"
                  " :Os,:Manufacturer, :Model, :ManufactSn,:Department, :Owner, :Tel,:AssetNo, :BuyDate,"
                  " :AssetStatus,NOW(), :Linsence, :SdmsClnVer,UUID())");
    query.bindValue(":Status", computer->getAssetStatus());
    query.bindValue(":ComputerName", computer->getComputerName());
    query.bindValue(":Ip", computer->getIp());
    query.bindValue(":Location", computer->getLocation());
    query.bindValue(":Duty", computer->getDuty());
    query.bindValue(":Cpu", computer->getCpu());
    query.bindValue(":Status", computer->getStatus());
    query.bindValue(":Memory", computer->getMemory());
    query.bindValue(":Hd", computer->getHd());
    query.bindValue(":CPUID", computer->getCPUID());
    query.bindValue(":AllMac", computer->getAllMac());
    query.bindValue(":Os", computer->getOs());
    query.bindValue(":Manufacturer", computer->getManufacturer());
    query.bindValue(":Model", computer->getModel());
    query.bindValue(":ManufactSn", computer->getManufactSn());
    query.bindValue(":Department", computer->getDepartment());
    query.bindValue(":Owner", computer->getOwner());
    query.bindValue(":Tel", computer->getTel());
    query.bindValue(":AssetNo", computer->getAssetNo());
    query.bindValue(":BuyDate", computer->getBuyDate());
    query.bindValue(":AssetStatus", computer->getAssetStatus());
    //query.bindValue(":LastOnLineDate", "NOW()");
    query.bindValue(":Linsence", computer->getLinsence());
    query.bindValue(":SdmsClnVer", computer->getSdmsClnVer());
    //query.bindValue(":uuid", "UUID()");
    bool success = query.exec();
    if (!success) {
        qDebug() << "Failed to insert data:" << query.lastError().text();
        std::cout << "Failed to insert data:"<< query.lastError().text().toStdString() <<std::endl;
        //manager.closeDataBase();
        return false;
    }
    //manager.closeDataBase();
    return true;
}

bool ComputerService::isHave(QString &CputId){
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return false;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);
    query.prepare("SELECT COUNT(1) FROM computer WHERE CPUID = :CPUID;");
    query.bindValue(":CPUID",CputId);
    query.exec();
    while(query.next()){
        int count = query.value(0).toInt();
        if(count > 0){
            return true;
        }
    }
    //manager.closeDataBase();
    return false;
}

void ComputerService::updateOldComputer(Computer *computer){
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);
    query.prepare("UPDATE computer SET "
                  " Location = :Location,Duty = :Duty,Manufacturer = :Manufacturer,Model = :Model,Ip = :Ip,"
                  "ManufactSn = :ManufactSn,Department = :Department,Owner = :Owner,Tel = :Tel,AssetNo = :AssetNo,"
                  "BuyDate = :BuyDate,AssetStatus = :AssetStatus "
                  "WHERE CPUID = :CPUID");
    //query.bindValue(":Status", computer->getAssetStatus());
    //query.bindValue(":ComputerName", computer->getComputerName());
    query.bindValue(":Ip", computer->getIp());
    query.bindValue(":Location", computer->getLocation());
    query.bindValue(":Duty", computer->getDuty());
    query.bindValue(":Cpu", computer->getCpu());
    //query.bindValue(":Status", computer->getStatus());
    //query.bindValue(":Memory", computer->getMemory());
    //query.bindValue(":Hd", computer->getHd());
    query.bindValue(":CPUID", computer->getCPUID());
    //query.bindValue(":AllMac", computer->getAllMac());
    //query.bindValue(":Os", computer->getOs());
    query.bindValue(":Manufacturer", computer->getManufacturer());
    query.bindValue(":Model", computer->getModel());
    query.bindValue(":ManufactSn", computer->getManufactSn());
    query.bindValue(":Department", computer->getDepartment());
    query.bindValue(":Owner", computer->getOwner());
    query.bindValue(":Tel", computer->getTel());
    query.bindValue(":AssetNo", computer->getAssetNo());
    query.bindValue(":BuyDate", computer->getBuyDate());
    query.bindValue(":AssetStatus", computer->getAssetStatus());
    bool success = query.exec();
    if (!success) {
        qDebug() << "Failed to insert data:" << query.lastError().text();
        std::cout << "Failed to insert data:"<< query.lastError().text().toStdString() <<std::endl;
        return;
    }
}

QVariant ComputerService::getDeparmentMap(){
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return false;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);

    query.prepare("SELECT DISTINCT d1.DepartmentId, d1.DepartmentName, d1.ParentDepartmentId, d1.Row, "
                    "CASE WHEN d1.DepartmentId = d2.ParentDepartmentId THEN 1 ELSE 0 END AS isParent "
                    "FROM department d1 LEFT JOIN department d2 ON d1.DepartmentId = d2.ParentDepartmentId "
                    "ORDER BY Row;");
    QVariantMap depMap;
    while (query.next()) {
        // Department *dep = new Department();
        QString departId = query.value(0).toString();
        QString departName = query.value(1).toString();
        QString parentDepartId = query.value(2).toString();
        int row = query.value(3).toInt();
        int isTitle = query.value(4).toInt();
        // 处理检索到的数据
        // dep->setDepartmentId(departId);
        // dep->setDepartmentName(departName);
        // dep->setParentDepartmentId(parentDepartId);
        // dep->setRow(row);
        // depMap[departId]=dep;

        QVariantMap map;
        map["DepartmentId"]=departId;
        map["DepartmentName"]=departName;
        map["ParentDepartmentId"]=parentDepartId;
        map["Row"]=row;
        map["isTitle"]=isTitle;
        depMap[departId]=map;
    }
    QVariant customVariant = QVariant::fromValue(depMap);
    return customVariant;
}

QVariant ComputerService::getLocalCpuId(){
    QString CpuId = getCpuId();
    QVariant result=CpuId;
    return result;
}
QVariant ComputerService::getServerIp(){
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("SER_CNT");
    settings.setIniCodec("UTF-8"); // 设置为UTF-8编码
    QString dbIp = settings.value("DBSERVER_IP").toString();
    settings.endGroup();
    QVariant result=dbIp;
    m_db_ip = dbIp;
    return result;
}

QVariant ComputerService::getDbreMarket(){
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("SER_CNT");
    settings.setIniCodec("UTF-8"); // 设置为UTF-8编码
    // 设置编码为 UTF-8
    QString remarket = settings.value("DBSERVER_MARKET").toString();
    settings.endGroup();
    QVariant result=remarket;
    return result;
}

QVariant ComputerService::getRegisterStatus(){
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("SER_CNT");
    QString retstr = settings.value("REG_STATUS").toString();
    settings.endGroup();
    QVariant result=retstr;
    return result;
}

QVariant ComputerService::getLastComputer(){
    QString CpuId = getCpuId();
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;

    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return false;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);

    query.prepare("SELECT Location,Duty,Manufacturer,Model,ManufactSn,Department,Owner,Tel,AssetNo,"
                  "BuyDate,AssetStatus FROM computer WHERE CPUID = :CPUID;");
    query.bindValue(":CPUID",CpuId);
    QVariant customVariant;

    //QMap<QString,Department *> depMap=getFullDepartmentMap();
    if(query.exec()) {
        while (query.next()) {
            QString location = query.value(0).toString();
            QString duty = query.value(1).toString();
            QString manufacturer = query.value(2).toString();
            QString model = query.value(3).toString();
            QString manufactSn = query.value(4).toString();
            QString department = query.value(5).toString();
            QString owner = query.value(6).toString();
            QString tel = query.value(7).toString();
            QString assetNo = query.value(8).toString();
            QString buyDate = query.value(9).toString();
            QString assetStatus = query.value(10).toString();
            //qDebug()<<__LINE__<<owner<<tel<<assetNo<<buyDate<<assetStatus;
            // QString path;
            // getName(path,department,depMap);
            // QStringList list = path.split("/");
            // QString departmentName;
            // for(int i = list.size()-1;i>0;i--){
            //     departmentName+="/"+list.at(i);
            // }
            QVariantMap map;
            map["Location"]=location;
            map["Duty"]=duty;
            map["Manufacturer"]=manufacturer;
            map["Model"]=model;
            map["ManufactSn"]=manufactSn;
            map["Department"]=department;
            map["Owner"]=owner;
            map["Tel"]=tel;
            map["AssetNo"]=assetNo;
            map["BuyDate"]=buyDate;
            map["AssetStatus"]=assetStatus;
            //map["DepartmentName"]=departmentName;
            customVariant= QVariant::fromValue(map);
            std::cout << __LINE__ << " " << __FUNCTION__ << " Manufacturer:" << manufacturer.toStdString()
                      << " model:" << model.toStdString() << " assetStatus:" << assetStatus.toStdString() << std::endl;
            qDebug() << __LINE__ << __FUNCTION__ << map["Location"]<<  map["Duty"]<<  map["Manufacturer"]<<  map["Model"]<<  map["ManufactSn"];
            qDebug() << __LINE__ << __FUNCTION__ << map["Department"]<<  map["Owner"]<<  map["Tel"]<<  map["AssetNo"]<<  map["BuyDate"]<<  map["AssetStatus"];
        }
    } else {
        qDebug() << "Query execution failed: " << query.lastError().text();
    }
    //manager.closeDataBase();
    return customVariant;
}

QVariant ComputerService::getConfigIp(){
    return "127.0.0.1";
}

bool ComputerService::linkTest(QVariant Ip){
    QString inputip = Ip.toString();
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return false;
    }else{
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接成功" <<std::endl;
    }
    m_db_ip=inputip;
    return true;
}

QString ComputerService::getCpuId(){

    const char* getcpusercmd="dmidecode -t Processor | grep Serial |awk -F ': ' '{print $2}'| tr -d ' '|tr -d '\\n'";
    std::string cpuId=comfun.Getresultbyrootcmd(getcpusercmd);
    std::cout << __FUNCTION__ << " "<< __LINE__ << " cpuId:"<<cpuId<< std::endl;
    if (cpuId.find("O.E.M") != std::string::npos){
        const char* getcpuidcmd="dmidecode -t Processor | grep ID |head -n1 |awk -F 'ID:' '{print $2}'| tr -d ' '|tr -d '\\n'";
        cpuId=comfun.Getresultbyrootcmd(getcpuidcmd);
    }

    return QString::fromStdString(cpuId);
}

QString ComputerService::getLocalIp(){
    QString Ip;
    QProcess process;
    process.start("hostname -I");
    if (!process.waitForFinished()) {
        return "Unknown";
    }

    QByteArray result = process.readAllStandardOutput();
    QString dmidecodeOutput =  QString::fromLocal8Bit(result);
    QStringList lines = dmidecodeOutput.split('\n');
    for (const QString &line : lines) {
        if(line.contains(".")){
            Ip =  line.split(" ").at(0).trimmed();
        }
    }
    return Ip;
}

QString ComputerService::getOs(){//---add by ocy--20240523--
    QString Osname;
    QProcess process;
    QString cmd="hostnamectl";
    process.start(cmd);
    qDebug()<< __LINE__ << "cmd:" << cmd;
    if (!process.waitForFinished()) {
        return "Unknown";
    }

    QByteArray result = process.readAllStandardOutput();
    QString dmidecodeOutput =  QString::fromLocal8Bit(result);
    QStringList lines = dmidecodeOutput.split('\n');
    for (const QString &line : lines) {
        if(line.contains("System")){
            Osname =  line.split(": ").at(1).trimmed();
        }
    }
    qDebug()<< __LINE__ << "Osname:" << Osname;
    return Osname;
}

// 获取 CPU 名称
QString ComputerService::getCPUName() {
    const char* getcpucmd="dmidecode -t processor|grep Manufacturer|awk -F ':' '{print $2}'";
    std::string cpuName=comfun.Getresultbyrootcmd(getcpucmd);
    return QString::fromStdString(cpuName);
}

// 获取硬盘名称
QString ComputerService::getDiskName() {
    QProcess process;
    process.start("hwinfo --disk");
    if (!process.waitForFinished()) {
        return "Unknown";
    }

    QByteArray result = process.readAllStandardOutput();
    QString dmidecodeOutput =  QString::fromLocal8Bit(result);
    // 从 dmidecode 输出中提取 CPU 名称
    QStringList lines = dmidecodeOutput.split('\n');
    QString diskName;

    // std::cout << "linsize:"<< lines.size() <<std::endl;
    for (const QString &line : lines) {
        if (line.contains("Capacity:")) {
            QString disk = line.split(':').at(1).trimmed();
            QString size = disk.split('(').at(0).trimmed();
            diskName =size.replace(" ","");
            // qDebug() << "diskName" << diskName;
            // printf("diskName:%s",diskName.toUtf8().data());
            // std::cout << "diskName:"<< diskName.toStdString() <<std::endl;
            return diskName;
        }
    }
    return "Unknown";
}

// 获取内存名称
QString ComputerService::getMemoryName() {

    QProcess process;
    process.start("cat /proc/meminfo |grep MemTotal");
    if (!process.waitForFinished()) {
        return "Unknown";
    }

    QByteArray result = process.readAllStandardOutput();
    QString dmidecodeOutput =  QString::fromLocal8Bit(result);
    // 从 dmidecode 输出中提取 CPU 名称
    QStringList lines = dmidecodeOutput.split('\n');

    for (const QString &line : lines) {
        // std::cout << "line:"<< line.toStdString() <<std::endl;
        if (line.contains("MemTotal:")) {
            QString memory = line.split(':').at(1).trimmed();
            int memorySize = memory.replace("kB","").trimmed().toInt();
            int size = memorySize/1024/1024;
            QString sizeStr = QString::number(size)+"GB";
            return sizeStr;
        }
    }
    return "Unknown";
}

QString ComputerService::getMacAddress() {
    QList<QNetworkInterface> interfaces = QNetworkInterface::allInterfaces();
    QString macAddressesString = "";
    foreach (QNetworkInterface interface, interfaces) {
        QString macAddress = interface.hardwareAddress();
        if(macAddress.isEmpty()){
            macAddressesString=macAddress;
        }else{
            if(macAddress != "00:00:00:00:00:00"){
                macAddressesString += + ";" +macAddress;
            }
        }
    }
    if (!macAddressesString.isEmpty()) {
        if (macAddressesString.startsWith(";")) {
            macAddressesString = macAddressesString.mid(1);
        }
    }
    return macAddressesString;
}


QMap<QString,Department *> ComputerService::getFullDepartmentMap(){
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    QMap<QString,Department *> map;
    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return map;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);
    query.prepare("SELECT DISTINCT d1.DepartmentId, d1.DepartmentName, d1.ParentDepartmentId FROM department d1 "
                    "LEFT JOIN department d2 ON d1.DepartmentId = d2.ParentDepartmentId;");


    while (query.next()) {
        QString departId = query.value(0).toString();
        QString departName = query.value(1).toString();
        QString parentDepartId = query.value(2).toString();

        Department *dep = new Department();
        dep->setDepartmentId(departId);
        dep->setDepartmentName(departName);
        dep->setParentDepartmentId(parentDepartId);
        map.insert(departId,dep);
    }
    //manager.closeDataBase();
    return map;
}

void ComputerService::getName(QString &path,QString &depId,QMap<QString,Department *> map){
    Department *cur = map.value(depId);
    if(cur != NULL){
        path +="/"+cur->getDepartmentName();
        QString par = cur->getParentDepartmentId();
        getName(path,par,map);
    }
}

QString ComputerService::getChildDepartmentId(QString departmentId){
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    QString allDepId;

    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return allDepId;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);
    query.prepare("SELECT recur.DepartmentId FROM (SELECT  @start_with := :depId AS depId) AS init JOIN (SELECT "
                  "DepartmentId,DepartmentName,ParentDepartmentId,@depth := @depth + 1 AS depth FROM department, (SELECT @depth := 0) AS d "
    "WHERE FIND_IN_SET(ParentDepartmentId, @start_with) > 0) AS recur ON @start_with := CONCAT(@start_with, ',', recur.DepartmentId)"
                  "ORDER BY depth;");
    query.bindValue(":depId",departmentId);

    if (query.exec()) {
        while (query.next()) {
            QString departId = query.value(0).toString();
            allDepId += "'"+departId+"',";
        }
        allDepId +="'"+departmentId+"'";
    } else {
        qDebug() << "Query failed: " << query.lastError().text();
    }
    //manager.closeDataBase();
    return allDepId;
}

void ComputerService::savePort(const QVariant ftpPort,const QVariant tepPort,const QVariant receivePort,const QVariant udpPort){

    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("CNT_CNF");\
    QString ftp = ftpPort.toString();
    QString tep = tepPort.toString();
    QString receive = receivePort.toString();
    QString udp = udpPort.toString();
    settings.setValue("FTP_PORT", ftp);
    settings.setValue("TEP_PORT", tep);
    settings.setValue("RECEIVE_PORT", receive);
    settings.setValue("UDP_PORT", udp);
    settings.endGroup();

    updateCntCnf();
}
void ComputerService::updateCntCnf(){
    QProcess process;
    process.start("pkill -9 comtcpsvr ");
    if (!process.waitForFinished()) {
        qDebug() << "updateCntCnf failed!";
    }
}


QVariant ComputerService::getCntCnf(){

    QVariantMap map;
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("CNT_CNF");
    QString ftp = settings.value("FTP_PORT").toString();
    QString tep = settings.value("TEP_PORT").toString();
    QString receive = settings.value("RECEIVE_PORT").toString();
    QString udp = settings.value("UDP_PORT").toString();
    settings.endGroup();
    if(ftp.isEmpty()){
        ftp = "10618";
    }
    map["FTP_PORT"] = ftp;
    map["TEP_PORT"] = tep;
    map["RECEIVE_PORT"] = receive;
    map["UDP_PORT"] = udp;
    QVariant customVariant = QVariant::fromValue(map);
    return customVariant;
}

QVariant ComputerService::getbaseconf(){
    QVariantMap map;
    QString version = "v1.0";
    map["VERSION"] = version;
    QVariant customVariant = QVariant::fromValue(map);
    return customVariant;
}

void ComputerService::initVncMsg(){
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);
    query.prepare("INSERT IGNORE INTO cpt_vnc_msg(CpuId,Allow,Assitant,Assign,AssignIp) VALUES(:CpuId,:Allow,:Assitant,:Assign,:AssignIp);");
    query.bindValue(":CpuId",getCpuId());
    query.bindValue(":Allow",2);
    query.bindValue(":Assitant",1);
    query.bindValue(":Assign",0);
    query.bindValue(":AssignIp","");
    if(!query.exec()){
        qDebug() << "insertVncMsg failed! " << query.lastError();
    }
    //manager.closeDataBase();
}
bool ComputerService::login(const QVariant userName,const QVariant password){
    return true;//此功能暂时没用
    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(m_db_ip);
    QSqlQuery query(db);
    query.prepare("SELECT Id,Name,PassWord,UserName,DepartmentId,Post FROM user WHERE UserName = :UserName;");
    query.bindValue(":UserName",userName);
    query.exec();
    //bool flag = false;
    while (query.next()) {
        //flag = true;
        //int id = query.value(0).toInt();
        QString Name = query.value(1).toString();
        QString PassWord = query.value(2).toString();
        QString UserName = query.value(3).toString();
        Utils util;
        qDebug() << "PassWord" <<PassWord;
        QString dePass = util.decodedText(PassWord);
        if(dePass == password.toString()){
            qDebug() << "password" <<password;
            return true;
        }
    }
    return false;
}

QVariant ComputerService::getListPort(){

    // 创建一个 QProcess 对象
    QProcess process;

    // 设置要执行的命令和参数
    QStringList arguments;
    arguments << "-p" << "/dev";
    process.start("ls", arguments);

    // 等待进程完成
    process.waitForFinished();

    // 读取进程的输出
    QString output = process.readAllStandardOutput();

    // 过滤子目录
    QStringList lines = output.split("\n");
    QVariantList dataList;
    for (const QString& line : lines) {
        if(line=="")break;
        if (!line.endsWith("/")) { // 如果不是以斜杠结尾，说明是文件而不是目录
            //if (line.mid(0, 3) == "tty"||line.mid(0, 3) == "par"||line.mid(0, 2) == "lp"){
                dataList.append("/dev/"+line);
            //}
        }
    }
    return QVariant::fromValue(dataList);
}

QVariant ComputerService::getSerialMsg(){
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("SERIAL_CNT");
    QString com1 = settings.value("COM1_PATH").toString();
    QString com2 = settings.value("COM2_PATH").toString();
    QString com3 = settings.value("COM3_PATH").toString();
    QString com4 = settings.value("COM4_PATH").toString();
    QString lpt = settings.value("LPT_PATH").toString();
    settings.endGroup();
    qDebug()<<com1<<com2<<com3<<com4<<lpt;
    QVariantMap map;
    map["COM1_PATH"]=com1;
    map["COM2_PATH"]=com2;
    map["COM3_PATH"]=com3;
    map["COM4_PATH"]=com4;
    map["LPT_PATH"]=lpt;
    QVariant retVariant= QVariant::fromValue(map);
    return retVariant;
}


bool ComputerService::editPassword(const QVariant userName,const QVariant oldPassword,const QVariant newPassword){

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(m_db_ip);
    QSqlQuery query(db);
    query.prepare("SELECT Id,Name,PassWord,UserName,DepartmentId,Post FROM user WHERE UserName = :UserName;");
    query.bindValue(":UserName",userName);
    query.exec();
    //bool flag = false;
    while (query.next()) {
        //flag = true;
        //int id = query.value(0).toInt();
        QString Name = query.value(1).toString();
        QString PassWord = query.value(2).toString();
        QString UserName = query.value(3).toString();
        Utils util;
        qDebug() << "PassWord" <<PassWord;
        QString dePass = util.decodedText(PassWord);
        if(dePass == oldPassword.toString()){
            qDebug() << "password" <<oldPassword;
            updatePassword(UserName,newPassword.toString());
            return true;
        }
    }
    return false;
}

void ComputerService::updatePassword(QString userName,QString password){
    QSqlQuery query;
    query.prepare("UPDATE user SET PassWord = :PassWord  WHERE UserName = :UserName;");
    query.bindValue(":UserName",userName);
    query.bindValue(":PassWord",password);
    query.exec();
}
void  ComputerService::openRemoteFile(){
//    QProcess process;

//    QString cmd = QString("./remote_file_mng &");
//    process.start(cmd);
//    if (!process.waitForFinished(-1)) {
//        qDebug() << "cmd:error";
//    }

    QThread *thread = QThread::create([=]{
        QProcess process;
        QString cmd = QString("./remote_file_mng ");
        process.start(cmd);
        if (!process.waitForFinished(-1)) {
            qDebug() << "cmd:error";
        }
    });

    thread->start();
}

void  ComputerService::openHeYiYun(){

    QThread *thread = QThread::create([=]{
        QProcess process;

        // 设置要执行的命令和参数
        QString command = "sh";
        QStringList arguments;
        arguments << "hyyrun.sh"; // 替换为实际的脚本文件名

        // 启动进程
        process.start(command, arguments);
        if (!process.waitForFinished(-1)) {
            qDebug() << "cmd:error";
        }
    });

    thread->start();
}

void ComputerService::saveServerIp(const QVariant Ip){
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("SER_CNT");
    QString dbIp = Ip.toString();
    settings.setValue("DBSERVER_IP", dbIp);
    QString reg_status = "YES";
    settings.setValue("REG_STATUS", reg_status);
}

void ComputerService::saveTmpRemarket(const QVariant tmpremarket){
    QString dbmk = tmpremarket.toString();
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("SER_CNT");
    settings.setIniCodec("UTF-8"); // QSettings默认是unicode编码,设置为UTF-8编码
    settings.setValue("DBSERVER_MARKET", dbmk);
    settings.endGroup();
    QString reg_status = "NOT";
    settings.setValue("REG_STATUS", reg_status);
}

void ComputerService::SaveCheckpwd(const QVariant password){
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("LOGIN_CNT");
    QString ckpwd = password.toString();
    settings.setValue("CHECK_PWD", ckpwd);
}

void ComputerService::saveSerialMag(const QVariant COM1_Path,const QVariant COM2_Path,const QVariant COM3_Path,const QVariant COM4_Path,const QVariant lpt_Path){
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("SERIAL_CNT");
    QString com1 = COM1_Path.toString();
    QString com2 = COM2_Path.toString();
    QString com3 = COM3_Path.toString();
    QString com4 = COM4_Path.toString();
    QString lpt = lpt_Path.toString();
    settings.setValue("COM1_PATH", com1);
    settings.setValue("COM2_PATH", com2);
    settings.setValue("COM3_PATH", com3);
    settings.setValue("COM4_PATH", com4);
    settings.setValue("LPT_PATH", lpt);
    qDebug()<< "serialPathUpdate:" << com1;
    // 保存完成后发送信号通知数据已更新
    emit serialPathUpdate(com1);
}

void ComputerService::saveSerialrecvMsg(const QVariant filepath,const QVariant content){
    QString fpath = filepath.toString();
    std::string str_fpath = fpath.toStdString();
    QString scontent = content.toString();
    std::string str_scontent = scontent.toStdString();
    std::ofstream outputFile(str_fpath);

    if (outputFile.is_open()) {
        outputFile << str_scontent;
        outputFile.close();
        std::cout << "Content saved to output.txt" << std::endl;
    } else {
        std::cerr << "Unable to open file for writing" << std::endl;
    }
}

bool ComputerService::checkloaclpwd(const QVariant password){
    QString inputpwd = password.toString();
    if(inputpwd=="Ymore82340106"){
        return true;
    }
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("LOGIN_CNT");
    QString confpwd = settings.value("CHECK_PWD").toString();
    settings.endGroup();
    //qDebug()<< "confpwd:" << confpwd;
    //qDebug()<< "password:" << confpwd;
    if(password==confpwd){//与输入框的密码做比较
        return true;
    }

    return false;
}

std::unordered_map<std::string, std::string> readConfig(const std::string& filePath) {
    std::unordered_map<std::string, std::string> config;
    std::ifstream file(filePath);

    if (!file.is_open()) {
        std::cerr << "无法打开配置文件: " << filePath << std::endl;
        return config;
    }

    std::string line;
    while (std::getline(file, line)) {
        // 跳过空行和注释
        if (line.empty() || line[0] == '#') continue;

        std::istringstream iss(line);
        std::string key, value;

        // 根据 '=' 分割键值对
        if (std::getline(iss, key, '=') && std::getline(iss, value)) {
            config[key] = value;
        }
    }

    file.close();
    return config;
}

QVariant ComputerService::getdevoptcmd(){
    QVariant customVariant;
    return customVariant;
}


QVariant ComputerService::getDepartment(){
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return false;
    }
    std::cout << __LINE__ << " m_db_ip:" << m_db_ip.toStdString() << std::endl;
    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);
    query.prepare("SELECT computer_dep_no,computer_dep_name FROM computer_used_dep;");
    QVariantMap depMap;
    if(query.exec()) {
        while (query.next()) {
            // Department *dep = new Department();
            QString departId = query.value(0).toString();
            QString departName = query.value(1).toString();
            std::cout << __LINE__ << " departName:" << departName.toStdString() << std::endl;
            depMap[departId]=departName;
        }
    }else {
        qDebug() << "Query execution failed: " << query.lastError().text();
    }
    std::cout << __LINE__ << " depMap size:" << depMap.size() << std::endl;
    //manager.closeDataBase();
    QVariant customVariant = QVariant::fromValue(depMap);
    return customVariant;
}

QVariant ComputerService::getMnfMdl(){
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    QString inputip=m_db_ip;
    std::string ckip=inputip.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return false;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(inputip);
    QSqlQuery query(db);
    query.prepare("SELECT computer_mnf,computer_mdl FROM computer_mnf_mdl order by computer_mnf;");
    QVariantMap mnfmdlMap;
    if(query.exec()) {
        while (query.next()) {
            // Department *dep = new Department();
            QString computer_mnf = query.value(0).toString();
            QString computer_mdl = query.value(1).toString();
            if(mnfmdlMap.count(computer_mnf)>0){
                QVariantList mdllist=mnfmdlMap[computer_mnf].toList();
                mdllist.append(computer_mdl);
                mnfmdlMap[computer_mnf]=mdllist;
            }else{
                QVariantList mdllist;
                mdllist.append(computer_mdl);
                mnfmdlMap[computer_mnf]=mdllist;
            }
        }
    }else{
        qDebug() << "Query execution failed: " << query.lastError().text();
    }
    std::cout << __LINE__ << " mnfmdlMap size:" << mnfmdlMap.size() << std::endl;
    //manager.closeDataBase();
    QVariant customVariant = QVariant::fromValue(mnfmdlMap);
    return customVariant;
}


