#ifndef VNCMSG_H
#define VNCMSG_H

#include <QString>
#include <QObject>
class VncMsg: public QObject
{
    Q_OBJECT
public:
    VncMsg();
    VncMsg(const QString &CpuId, int Allow, int Assitant, int Assign, int AssignIp);


    QString getCpuId() const;
    void setCpuId(const QString &newCpuId);

    int getAllow() const;
    void setAllow(int newAllow);

    int getAssitant() const;
    void setAssitant(int newAssitant);

    int getAssign() const;
    void setAssign(int newAssign);

    int getAssignIp() const;
    void setAssignIp(int newAssignIp);

signals:
    void CpuIdChanged();

    void AllowChanged();

    void AssitantChanged();

    void AssignChanged();

    void AssignIpChanged();

private:
    QString CpuId;
    int Allow; // 0 ban  1 ask 2 allow
    int Assitant;  //0 read   1 option
    int Assign; //0 nocheced   1  checked
    int AssignIp;
    Q_PROPERTY(QString CpuId READ getCpuId WRITE setCpuId NOTIFY CpuIdChanged FINAL)
    Q_PROPERTY(int Allow READ getAllow WRITE setAllow NOTIFY AllowChanged FINAL)
    Q_PROPERTY(int Assitant READ getAssitant WRITE setAssitant NOTIFY AssitantChanged FINAL)
    Q_PROPERTY(int Assign READ getAssign WRITE setAssign NOTIFY AssignChanged FINAL)
    Q_PROPERTY(int AssignIp READ getAssignIp WRITE setAssignIp NOTIFY AssignIpChanged FINAL)
};

#endif // VNCMSG_H
