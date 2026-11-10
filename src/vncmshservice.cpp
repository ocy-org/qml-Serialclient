#include "vncmshservice.h"

typedef std::string (*Getcpuidbydmi)();

VncMshService::VncMshService() {
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("SER_CNT");
    m_dbIp = settings.value("DBSERVER_IP").toString();
    settings.endGroup();
}

QString VncMshService::getServerIp(){
    QSettings settings(PORTPATH, QSettings::IniFormat);
    settings.beginGroup("SER_CNT");
    QString dbIp = settings.value("DBSERVER_IP").toString();
    settings.endGroup();
    return dbIp;
}

QVariant VncMshService::getVncMsg(){
    std::cout << __LINE__ << " " << __FUNCTION__ << std::endl;
    QString cpuId = getCpuId();
    QVariantMap map;
    QVariant result;

    std::string ckip=m_dbIp.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return result;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(m_dbIp);
    QSqlQuery query(db);
    query.prepare("SELECT  Allow,Assitant,Assign,AssignIp,CpuId FROM cpt_vnc_msg WHERE CpuId = :CpuId;");
    query.bindValue(":CpuId",cpuId);
    if(query.exec()){
        while (query.next()) {
            int allow = query.value(0).toInt();
            int assitant = query.value(1).toInt();
            int assign = query.value(2).toInt();
            int assignIp = query.value(3).toInt();
            QString CpuId = query.value(4).toString();

            map["Allow"] = allow;
            map["Assitant"] = assitant;
            map["Assign"] = assign;
            map["AssignIp"] = assignIp;
            map["CpuId"] = CpuId;

            qDebug() << "get newAssitant:"<<assitant;
            result= QVariant::fromValue(map);
        }
    }

    manager.closeDataBase();
    return result;
}

QString VncMshService::getCpuId(){
    const char* getcpusercmd="dmidecode -t Processor | grep Serial |awk -F ': ' '{print $2}'| tr -d ' '|tr -d '\\n'";
    std::string cpuId=comfun.Getresultbyrootcmd(getcpusercmd);
    std::cout << __FUNCTION__ << " "<< __LINE__ << " cpuId:"<<cpuId<< std::endl;
    if (cpuId.find("O.E.M") != std::string::npos){
        const char* getcpuidcmd="dmidecode -t Processor | grep ID |head -n1 |awk -F 'ID:' '{print $2}'| tr -d ' '|tr -d '\\n'";
        cpuId=comfun.Getresultbyrootcmd(getcpuidcmd);
    }

    return QString::fromStdString(cpuId);
}


void VncMshService::updateVncMsg(VncMsg *vnc){
    std::string ckip=m_dbIp.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return ;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(m_dbIp);
    QSqlQuery query(db);
    query.prepare("UPDATE cpt_vnc_msg SET  Allow=:Allow,Assitant=:Assitant,Assign=:Assign,AssignIp=:AssignIp WHERE CpuId = :CpuId;");
    query.bindValue(":CpuId",vnc->getCpuId());
    query.bindValue(":Allow",vnc->getAllow());
    query.bindValue(":Assitant",vnc->getAssitant());
    query.bindValue(":Assign",vnc->getAssign());
    query.bindValue(":AssignIp",vnc->getAssignIp());
    if(!query.exec()){
        qDebug() << "updateVncMsg failed!"<< query.lastError();
    }else{
        qDebug() << "updateVncMsg success!";
    }
    manager.closeDataBase();
}

void VncMshService::insertVncMsg(VncMsg *vnc){

    std::string ckip=m_dbIp.toStdString();
    bool bret=comfun.checksqlonline(ckip,3306);
    if(bret==false){
        std::cout << __LINE__ << " 数据库服务器ip:" << ckip <<"链接失败" <<std::endl;
        return ;
    }

    DatabaseManager& manager = DatabaseManager::getInstance();
    QSqlDatabase db = manager.getDatabaseConnection(m_dbIp);
    QSqlQuery query(db);
    query.prepare("INSERT INTO cpt_vnc_msg(CpuId,Allow,Assitant,Assign,AssignIp) VAULES(:CpuId,:Allow,:Assitant,:Assign,:AssignIp)");
    query.bindValue(":CpuId",vnc->getCpuId());
    query.bindValue(":Allow",vnc->getAllow());
    query.bindValue(":Assitant",vnc->getAssitant());
    query.bindValue(":Assign",vnc->getAssign());
    query.bindValue(":AssignIp",vnc->getAssignIp());
    if(!query.exec()){
        qDebug() << "insertVncMsg failed!";
    }
    manager.closeDataBase();
}


void VncMshService::saveOrUpdateVncMsg(const QVariantMap vncMap){

    QVariant vncMsg = getVncMsg();


    int newAssitant = vncMap.value("Assitant").toInt();
    int Allow = vncMap.value("Allow").toInt();
    int Assign = vncMap.value("Assign").toInt();
    int AssignIp = vncMap.value("AssignIp").toInt();
    QString  CpuId = getCpuId();

    int oldAssitant = 0;
    if (vncMsg.canConvert<QVariantMap>()) {
        QVariantMap vncMsgMap = vncMsg.toMap();
        oldAssitant = vncMsgMap.value("Assitant").toInt();
    }
    if(newAssitant != oldAssitant){
        restartVnc(newAssitant);
    }
    VncMsg *vnc = new VncMsg();
    vnc->setCpuId(CpuId);
    vnc->setAllow(Allow);
    vnc->setAssign(Assign);
    vnc->setAssignIp(AssignIp);
    vnc->setAssitant(newAssitant);
    updateVncMsg(vnc);


}


void VncMshService::restartVnc(int type){
    // 停止 x11vnc 服务
    // QProcess stopProcess;
    // stopProcess.start("systemctl", QStringList() << "stop" << "x11vnc.service");
    // stopProcess.waitForFinished();

    // 复制文件到目标路径
    QProcess copyProcess;
    if(type == 1){
        qDebug() << "restartVnc ok!";
        copyProcess.start("cp", QStringList() << "-rf" << "../../bin/conf/opt_x11vnc.service" << "/lib/systemd/system/x11vnc.service");
    }else{
        copyProcess.start("cp", QStringList() << "-rf" << "../../bin/conf/view_x11vnc.service" << "/lib/systemd/system/x11vnc.service");

    }

    copyProcess.waitForFinished();


    // 启动 x11vnc 服务
    QProcess reloadProcess;
    reloadProcess.start("systemctl", QStringList() << "daemon-reload" );
    reloadProcess.waitForFinished();

    // 启动 x11vnc 服务
    QProcess startProcess;
    startProcess.start("systemctl", QStringList() << "restart" << "x11vnc.service");
    startProcess.waitForFinished();
    // qDebug() << "restartVnc ok!";
}



QVariant VncMshService::rebuildlpt(){
    QVariant result=1;
    bool chmodflag=false;
    //std::cout << __LINE__ << endl;
    //先检测lp文件是否存在，如果存在就不需要加载lp模块，直接给权限
    bool ret0=comfun.fileExists("/dev/lp0");
    bool ret1=comfun.fileExists("/dev/lp1");
    //std::cout << __LINE__ << endl;
    if(ret0==true || ret1==true){
        std::cout << __LINE__ << endl;
        chmodflag=true;
    }
    else{
        //bool Sret=comfun.fileExists("/dev/ttyS10");==测试用
        //std::cout << __LINE__ << " " << Sret << endl;
        //lp文件不存在时，加载lp模块后，（如果并口正常）系统自动分配lp文件
        comfun.execrootcmd("modprobe lp");//加载lp模块
        sleep(2);
        bool ret0=comfun.fileExists("/dev/lp0");
        bool ret1=comfun.fileExists("/dev/lp1");
        //加载lp模块后，要检测lp文件是否存在
        if(ret0==false && ret1==false) {//如果不存在就没必要给权限了
            result=0;
            chmodflag=false;
        }else chmodflag=true;
    }
    //std::cout << __LINE__ << endl;
    if(chmodflag==true)
        comfun.execrootcmd("chmod 777 /dev/lp*");

    return result;
}
