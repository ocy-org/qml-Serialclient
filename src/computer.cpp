#include "computer.h"
#include <iostream>

Computer::Computer() {}

int Computer::getId() const
{
    return Id;
}

void Computer::setId(int newId)
{
    Id = newId;
}

QString Computer::getStatus() const
{
    return Status;
}

void Computer::setStatus(const QString &newStatus)
{
    if (Status == newStatus)
        return;
    Status = newStatus;
    emit StatusChanged();
}

void Computer::resetStatus()
{
    setStatus({}); // TODO: Adapt to use your actual default value
}

QString Computer::getComputerName() const
{
    return ComputerName;
}

void Computer::setComputerName(const QString &newComputerName)
{
    if (ComputerName == newComputerName)
        return;
    ComputerName = newComputerName;
    emit ComputerNameChanged();
}

void Computer::resetComputerName()
{
    setComputerName({}); // TODO: Adapt to use your actual default value
}

QString Computer::getIp() const
{
    return Ip;
}

void Computer::setIp(const QString &newIp)
{
    if (Ip == newIp)
        return;
    Ip = newIp;
    emit IpChanged();
}

void Computer::resetIp()
{
    setIp({}); // TODO: Adapt to use your actual default value
}

QString Computer::getLocation() const
{
    return Location;
}

void Computer::setLocation(const QString &newLocation)
{
    if (Location == newLocation)
        return;
    Location = newLocation;
    emit LocationChanged();
}

QString Computer::getDuty() const
{
    return Duty;
}

void Computer::setDuty(const QString &newDuty)
{
    if (Duty == newDuty)
        return;
    Duty = newDuty;
    emit DutyChanged();
}

QString Computer::getCpu() const
{
    return Cpu;
}

void Computer::setCpu(const QString &newCpu)
{
    if (Cpu == newCpu)
        return;
    Cpu = newCpu;
    emit CpuChanged();
}

QString Computer::getMemory() const
{
    return Memory;
}

void Computer::setMemory(const QString &newMemory)
{
    if (Memory == newMemory)
        return;
    Memory = newMemory;
    emit MemoryChanged();
}

QString Computer::getHd() const
{
    return Hd;
}

void Computer::setHd(const QString &newHd)
{
    if (Hd == newHd)
        return;
    Hd = newHd;
    emit HdChanged();
}

QString Computer::getCPUID() const
{
    return CPUID;
}

void Computer::setCPUID(const QString &newCPUID)
{
    if (CPUID == newCPUID)
        return;
    CPUID = newCPUID;
    emit CPUIDChanged();
}

QString Computer::getAllMac() const
{
    return AllMac;
}

void Computer::setAllMac(const QString &newAllMac)
{
    if (AllMac == newAllMac)
        return;
    AllMac = newAllMac;
    emit AllMacChanged();
}

QString Computer::getOs() const
{
    return Os;
}

void Computer::setOs(const QString &newOs)
{
    if (Os == newOs)
        return;
    Os = newOs;
    emit OsChanged();
}

QString Computer::getManufacturer() const
{
    return Manufacturer;
}

void Computer::setManufacturer(const QString &newManufacturer)
{
    if (Manufacturer == newManufacturer)
        return;
    Manufacturer = newManufacturer;
    emit ManufacturerChanged();
}

QString Computer::getModel() const
{
    return Model;
}

void Computer::setModel(const QString &newModel)
{
    if (Model == newModel)
        return;
    Model = newModel;
    emit ModelChanged();
}

QString Computer::getManufactSn() const
{
    return ManufactSn;
}

void Computer::setManufactSn(const QString &newManufactSn)
{
    if (ManufactSn == newManufactSn)
        return;
    ManufactSn = newManufactSn;
    emit ManufactSnChanged();
}


QString Computer::getOwner() const
{
    return Owner;
}

void Computer::setOwner(const QString &newOwner)
{
    if (Owner == newOwner)
        return;
    Owner = newOwner;
    emit OwnerChanged();
}

QString Computer::getTel() const
{
    return Tel;
}

void Computer::setTel(const QString &newTel)
{
    if (Tel == newTel)
        return;
    Tel = newTel;
    emit TelChanged();
}

QString Computer::getAssetNo() const
{
    return AssetNo;
}

void Computer::setAssetNo(const QString &newAssetNo)
{
    if (AssetNo == newAssetNo)
        return;
    AssetNo = newAssetNo;
    emit AssetNoChanged();
}

QString Computer::getBuyDate() const
{
    return BuyDate;
}

void Computer::setBuyDate(const QString &newBuyDate)
{
    if (BuyDate == newBuyDate)
        return;
    BuyDate = newBuyDate;
    emit BuyDateChanged();
}

QString Computer::getAssetStatus() const
{
    return AssetStatus;
}

void Computer::setAssetStatus(const QString &newAssetStatus)
{
    if (AssetStatus == newAssetStatus)
        return;
    AssetStatus = newAssetStatus;
    emit AssetStatusChanged();
}

QString Computer::getUpdateTime() const
{
    return UpdateTime;
}

void Computer::setUpdateTime(const QString &newUpdateTime)
{
    if (UpdateTime == newUpdateTime)
        return;
    UpdateTime = newUpdateTime;
    emit UpdateTimeChanged();
}

QString Computer::getLastOnLineDate() const
{
    return LastOnLineDate;
}

void Computer::setLastOnLineDate(const QString &newLastOnLineDate)
{
    if (LastOnLineDate == newLastOnLineDate)
        return;
    LastOnLineDate = newLastOnLineDate;
    emit LastOnLineDateChanged();
}

QString Computer::getLinsence() const
{
    return Linsence;
}

void Computer::setLinsence(const QString &newLinsence)
{
    if (Linsence == newLinsence)
        return;
    Linsence = newLinsence;
    emit LinsenceChanged();
}

QString Computer::getEwf() const
{
    return Ewf;
}

void Computer::setEwf(const QString &newEwf)
{
    if (Ewf == newEwf)
        return;
    Ewf = newEwf;
    emit EwfChanged();
}

QString Computer::getSdmsClnVer() const
{
    return SdmsClnVer;
}

void Computer::setSdmsClnVer(const QString &newSdmsClnVer)
{
    if (SdmsClnVer == newSdmsClnVer)
        return;
    SdmsClnVer = newSdmsClnVer;
    emit SdmsClnVerChanged();
}

QString Computer::getWorkStyle() const
{
    return WorkStyle;
}

void Computer::setWorkStyle(const QString &newWorkStyle)
{
    if (WorkStyle == newWorkStyle)
        return;
    WorkStyle = newWorkStyle;
    emit WorkStyleChanged();
}

QString Computer::getDepartment() const
{
    return Department;
}

void Computer::setDepartment(const QString &newDepartment)
{
    if (Department == newDepartment)
        return;
    Department = newDepartment;
    emit DepartmentChanged();
}

int Computer::getUpdateOk() const
{
    return UpdateOk;
}

void Computer::setUpdateOk(int newUpdateOk)
{
    if (UpdateOk == newUpdateOk)
        return;
    UpdateOk = newUpdateOk;
    emit UpdateOkChanged();
}

int Computer::getFresh() const
{
    return Fresh;
}

void Computer::setFresh(int newFresh)
{
    if (Fresh == newFresh)
        return;
    Fresh = newFresh;
    emit FreshChanged();
}

int Computer::getHwChanged() const
{
    return HwChanged;
}

void Computer::setHwChanged(int newHwChanged)
{
    if (HwChanged == newHwChanged)
        return;
    HwChanged = newHwChanged;
    emit HwChangedChanged();
}
