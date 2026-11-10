#ifndef COMPUTERSERVICE_H
#define COMPUTERSERVICE_H

#include <QObject>
#include <QVariantMap>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QHostInfo>
#include <QNetworkInterface>
#include <QFile>
#include <QTextStream>
#include <QProcess>
#include <QDateTime>
#include <QDir>
#include <QThread>
#include <QTextCodec>
#include <fstream>
#include <string>
#include <iostream>
#include <string>
#include <sstream>
#include <unordered_map>
#include "DatabaseManager.h"
#include "computer.h"
#include "department.h"
#include "utils.h"
#include "commfuntion.h"


#include <cstring>
#include <cstdlib>
#include <unistd.h>

class ComputerService : public QObject
{
    Q_OBJECT
public:
    ComputerService();


    Q_INVOKABLE QVariant getLastComputer();
    Q_INVOKABLE QVariant getDeparmentMap();
    Q_INVOKABLE QVariant getConfigIp();
    Q_INVOKABLE QVariant getCntCnf();
    Q_INVOKABLE QVariant getListPort();
    Q_INVOKABLE QVariant getLocalCpuId();
    Q_INVOKABLE QVariant getServerIp();
    Q_INVOKABLE QVariant getSerialMsg();
    Q_INVOKABLE QVariant getRegisterStatus();
    Q_INVOKABLE QVariant getbaseconf();
    Q_INVOKABLE QVariant getdevoptcmd();
    Q_INVOKABLE QVariant getDepartment();
    Q_INVOKABLE QVariant getMnfMdl();
    Q_INVOKABLE QVariant getDbreMarket();

    bool insert(Computer *computer);
    bool isHave(QString &CpuId);
    Computer selectByCpuId(QString &CpuId);
    void updateOldComputer(Computer *computer);
    QString getCpuId();
    QString getLocalIp();
    QString getCPUName();
    QString getDiskName();
    QString getMemoryName();
    QString getMacAddress();
    QString getChildDepartmentId(QString departmentId);
    QString getOs();

    QMap<QString,Department *> getFullDepartmentMap();
    void getName(QString &path,QString &depId,QMap<QString,Department *> map);

    void updateCntCnf();
    void initVncMsg();
    void updatePassword(QString userName,QString password);


public slots:
    bool setComputer(const QVariantMap computerMap);
    bool linkTest(const QVariant Ip);
    void savePort(const QVariant ftpPort,const QVariant tepPort,const QVariant receivePort,const QVariant udpPort);
    void saveServerIp(const QVariant Ip);
    void saveTmpRemarket(const QVariant tmpremarket);
    bool login(const QVariant userName,const QVariant password);
    bool editPassword(const QVariant userName,const QVariant oldPassword,const QVariant newPassword);
    void openRemoteFile();
    void openHeYiYun();
    bool checkloaclpwd(const QVariant password);//验证本地保存的验证密码
    void SaveCheckpwd(const QVariant password);
    void saveSerialMag(const QVariant COM1_Path,const QVariant COM2_Path,const QVariant COM3_Path,const QVariant COM4_Path,const QVariant lpt_Path);
    void saveSerialrecvMsg(const QVariant filepath,const QVariant content);

signals:
    // 定义信号，在数据保存后通知其他组件
    void serialPathUpdate(const QString &serialPath);

private:
    QString m_db_ip;
    CommFuntion comfun;
};

#endif // COMPUTERSERVICE_H
