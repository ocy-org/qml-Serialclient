#include "department.h"

Department::Department() {}

int Department::getId() const
{
    return Id;
}

void Department::setId(int newId)
{
    if (Id == newId)
        return;
    Id = newId;
    emit IdChanged();
}

QString Department::getDepartmentId() const
{
    return DepartmentId;
}

void Department::setDepartmentId(const QString &newDepartmentId)
{
    if (DepartmentId == newDepartmentId)
        return;
    DepartmentId = newDepartmentId;
    emit DepartmentIdChanged();
}

QString Department::getDepartmentName() const
{
    return DepartmentName;
}

void Department::setDepartmentName(const QString &newDepartmentName)
{
    if (DepartmentName == newDepartmentName)
        return;
    DepartmentName = newDepartmentName;
    emit DepartmentNameChanged();
}

QString Department::getParentDepartmentId() const
{
    return ParentDepartmentId;
}

void Department::setParentDepartmentId(const QString &newParentDepartmentId)
{
    if (ParentDepartmentId == newParentDepartmentId)
        return;
    ParentDepartmentId = newParentDepartmentId;
    emit ParentDepartmentIdChanged();
}

int Department::getRow() const
{
    return Row;
}

void Department::setRow(int newRow)
{
    if (Row == newRow)
        return;
    Row = newRow;
    emit RowChanged();
}

Department::Department(int Id, const QString &DepartmentId, const QString &DepartmentName, const QString &ParentDepartmentId, int Row) : Id(Id),
    DepartmentId(DepartmentId),
    DepartmentName(DepartmentName),
    ParentDepartmentId(ParentDepartmentId),
    Row(Row)
{}
