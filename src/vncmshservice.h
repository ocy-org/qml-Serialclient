#ifndef VNCMSHSERVICE_H
#define VNCMSHSERVICE_H

#include <QObject>
#include <QVariant>
#include <QSqlQuery>
#include <QDebug>
#include <QProcess>
#include <unistd.h>  // 包含 sleep 的头文件
#include "vncmsg.h"
#include "DatabaseManager.h"
#include "commfuntion.h"

class VncMshService: public QObject
{
    Q_OBJECT
public:
    VncMshService();


    Q_INVOKABLE QVariant getVncMsg();
    Q_INVOKABLE QVariant rebuildlpt();



    QString getCpuId();
    void updateVncMsg(VncMsg *vnc);
    void insertVncMsg(VncMsg *vnc);
    void restartVnc(int type);

public slots:
    void saveOrUpdateVncMsg(const QVariantMap vncMap);

private:
    QString getServerIp();
    CommFuntion comfun;
    QString m_dbIp;
};

#endif // VNCMSHSERVICE_H
