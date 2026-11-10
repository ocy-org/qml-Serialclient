#ifndef COMPUTER_H
#define COMPUTER_H

#include <QObject>
#include <QVariantMap>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>

#include "DatabaseManager.h"
class Computer : public QObject
{
    Q_OBJECT
public:
    Computer();






    int getId() const;
    void setId(int newId);

    QString getStatus() const;
    void setStatus(const QString &newStatus);
    void resetStatus();

    QString getComputerName() const;
    void setComputerName(const QString &newComputerName);
    void resetComputerName();

    QString getIp() const;
    void setIp(const QString &newIp);
    void resetIp();

    QString getLocation() const;
    void setLocation(const QString &newLocation);

    QString getDuty() const;
    void setDuty(const QString &newDuty);

    QString getCpu() const;
    void setCpu(const QString &newCpu);

    QString getMemory() const;
    void setMemory(const QString &newMemory);

    QString getHd() const;
    void setHd(const QString &newHd);

    QString getCPUID() const;
    void setCPUID(const QString &newCPUID);

    QString getAllMac() const;
    void setAllMac(const QString &newAllMac);

    QString getOs() const;
    void setOs(const QString &newOs);

    QString getManufacturer() const;
    void setManufacturer(const QString &newManufacturer);

    QString getModel() const;
    void setModel(const QString &newModel);

    QString getManufactSn() const;
    void setManufactSn(const QString &newManufactSn);



    QString getOwner() const;
    void setOwner(const QString &newOwner);

    QString getTel() const;
    void setTel(const QString &newTel);

    QString getAssetNo() const;
    void setAssetNo(const QString &newAssetNo);

    QString getBuyDate() const;
    void setBuyDate(const QString &newBuyDate);

    QString getAssetStatus() const;
    void setAssetStatus(const QString &newAssetStatus);

    QString getUpdateTime() const;
    void setUpdateTime(const QString &newUpdateTime);

    QString getLastOnLineDate() const;
    void setLastOnLineDate(const QString &newLastOnLineDate);

    QString getLinsence() const;
    void setLinsence(const QString &newLinsence);

    QString getEwf() const;
    void setEwf(const QString &newEwf);

    QString getSdmsClnVer() const;
    void setSdmsClnVer(const QString &newSdmsClnVer);

    QString getWorkStyle() const;
    void setWorkStyle(const QString &newWorkStyle);

    QString getDepartment() const;
    void setDepartment(const QString &newDepartment);

    int getUpdateOk() const;
    void setUpdateOk(int newUpdateOk);

    int getFresh() const;
    void setFresh(int newFresh);

    int getHwChanged() const;
    void setHwChanged(int newHwChanged);

signals:
    void StatusChanged();

    void ComputerNameChanged();

    void IpChanged();

    void LocationChanged();

    void DutyChanged();

    void CpuChanged();

    void MemoryChanged();

    void HdChanged();

    void CPUIDChanged();

    void AllMacChanged();

    void OsChanged();


    void ManufacturerChanged();

    void ModelChanged();

    void ManufactSnChanged();


    void OwnerChanged();

    void TelChanged();

    void AssetNoChanged();

    void BuyDateChanged();

    void AssetStatusChanged();

    void UpdateTimeChanged();

    void LastOnLineDateChanged();

    void LinsenceChanged();

    void EwfChanged();

    void SdmsClnVerChanged();

    void WorkStyleChanged();

    void DepartmentChanged();

    void UpdateOkChanged();

    void FreshChanged();

    void HwChangedChanged();

private:
    int Id;
    QString Status;
    QString ComputerName;
    QString Ip;
    QString Location;
    QString Duty;
    QString Cpu;
    QString Memory;
    QString Hd;
    QString CPUID;
    QString AllMac;
    QString Os;
    int UpdateOk;
    QString Manufacturer;
    QString Model;
    QString ManufactSn;
    QString Department;
    QString Owner;
    QString Tel;
    QString AssetNo;
    QString BuyDate;
    QString AssetStatus;
    QString UpdateTime;
    QString LastOnLineDate;
    QString Linsence;
    QString Ewf;
    QString UnDefine1;
    QString UnDefine2;
    QString UnDefine3;
    QString SdmsClnVer;
    QString WorkStyle;
    int Fresh;
    int HwChanged;
    Q_PROPERTY(QString Status READ getStatus WRITE setStatus RESET resetStatus NOTIFY StatusChanged FINAL)
    Q_PROPERTY(QString ComputerName READ getComputerName WRITE setComputerName RESET resetComputerName NOTIFY ComputerNameChanged FINAL)
    Q_PROPERTY(QString Ip READ getIp WRITE setIp RESET resetIp NOTIFY IpChanged FINAL)
    Q_PROPERTY(QString Location READ getLocation WRITE setLocation NOTIFY LocationChanged FINAL)
    Q_PROPERTY(QString Duty READ getDuty WRITE setDuty NOTIFY DutyChanged FINAL)
    Q_PROPERTY(QString Cpu READ getCpu WRITE setCpu NOTIFY CpuChanged FINAL)
    Q_PROPERTY(QString Memory READ getMemory WRITE setMemory NOTIFY MemoryChanged FINAL)
    Q_PROPERTY(QString Hd READ getHd WRITE setHd NOTIFY HdChanged FINAL)
    Q_PROPERTY(QString CPUID READ getCPUID WRITE setCPUID NOTIFY CPUIDChanged FINAL)
    Q_PROPERTY(QString AllMac READ getAllMac WRITE setAllMac NOTIFY AllMacChanged FINAL)
    Q_PROPERTY(QString Os READ getOs WRITE setOs NOTIFY OsChanged FINAL)
    Q_PROPERTY(QString Manufacturer READ getManufacturer WRITE setManufacturer NOTIFY ManufacturerChanged FINAL)
    Q_PROPERTY(QString Model READ getModel WRITE setModel NOTIFY ModelChanged FINAL)
    Q_PROPERTY(QString ManufactSn READ getManufactSn WRITE setManufactSn NOTIFY ManufactSnChanged FINAL)
    Q_PROPERTY(QString Owner READ getOwner WRITE setOwner NOTIFY OwnerChanged FINAL)
    Q_PROPERTY(QString Tel READ getTel WRITE setTel NOTIFY TelChanged FINAL)
    Q_PROPERTY(QString AssetNo READ getAssetNo WRITE setAssetNo NOTIFY AssetNoChanged FINAL)
    Q_PROPERTY(QString BuyDate READ getBuyDate WRITE setBuyDate NOTIFY BuyDateChanged FINAL)
    Q_PROPERTY(QString AssetStatus READ getAssetStatus WRITE setAssetStatus NOTIFY AssetStatusChanged FINAL)
    Q_PROPERTY(QString UpdateTime READ getUpdateTime WRITE setUpdateTime NOTIFY UpdateTimeChanged FINAL)
    Q_PROPERTY(QString LastOnLineDate READ getLastOnLineDate WRITE setLastOnLineDate NOTIFY LastOnLineDateChanged FINAL)
    Q_PROPERTY(QString Linsence READ getLinsence WRITE setLinsence NOTIFY LinsenceChanged FINAL)
    Q_PROPERTY(QString Ewf READ getEwf WRITE setEwf NOTIFY EwfChanged FINAL)
    Q_PROPERTY(QString SdmsClnVer READ getSdmsClnVer WRITE setSdmsClnVer NOTIFY SdmsClnVerChanged FINAL)
    Q_PROPERTY(QString WorkStyle READ getWorkStyle WRITE setWorkStyle NOTIFY WorkStyleChanged FINAL)
    Q_PROPERTY(QString Department READ getDepartment WRITE setDepartment NOTIFY DepartmentChanged FINAL)
    Q_PROPERTY(int UpdateOk READ getUpdateOk WRITE setUpdateOk NOTIFY UpdateOkChanged FINAL)
    Q_PROPERTY(int Fresh READ getFresh WRITE setFresh NOTIFY FreshChanged FINAL)
    Q_PROPERTY(int HwChanged READ getHwChanged WRITE setHwChanged NOTIFY HwChangedChanged FINAL)
};

#endif // COMPUTER_H
