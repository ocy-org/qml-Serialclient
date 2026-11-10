#include "vncmsg.h"

VncMsg::VncMsg()
{

}

QString VncMsg::getCpuId() const
{
    return CpuId;
}

void VncMsg::setCpuId(const QString &newCpuId)
{
    if (CpuId == newCpuId)
        return;
    CpuId = newCpuId;
    emit CpuIdChanged();
}

int VncMsg::getAllow() const
{
    return Allow;
}

void VncMsg::setAllow(int newAllow)
{
    if (Allow == newAllow)
        return;
    Allow = newAllow;
    emit AllowChanged();
}

int VncMsg::getAssitant() const
{
    return Assitant;
}

void VncMsg::setAssitant(int newAssitant)
{
    if (Assitant == newAssitant)
        return;
    Assitant = newAssitant;
    emit AssitantChanged();
}

int VncMsg::getAssign() const
{
    return Assign;
}

void VncMsg::setAssign(int newAssign)
{
    if (Assign == newAssign)
        return;
    Assign = newAssign;
    emit AssignChanged();
}

int VncMsg::getAssignIp() const
{
    return AssignIp;
}

void VncMsg::setAssignIp(int newAssignIp)
{
    if (AssignIp == newAssignIp)
        return;
    AssignIp = newAssignIp;
    emit AssignIpChanged();
}

VncMsg::VncMsg(const QString &CpuId, int Allow, int Assitant, int Assign, int AssignIp) : CpuId(CpuId),
    Allow(Allow),
    Assitant(Assitant),
    Assign(Assign),
    AssignIp(AssignIp)
{}





