#ifndef DEPARTMENT_H
#define DEPARTMENT_H
#include <QObject>
#include <QString>
class Department: public QObject
{
    Q_OBJECT
public:
    Department();
    Department(int Id, const QString &DepartmentId, const QString &DepartmentName, const QString &ParentDepartmentId, int Row);



    int getId() const;
    void setId(int newId);

    QString getDepartmentId() const;
    void setDepartmentId(const QString &newDepartmentId);

    QString getDepartmentName() const;
    void setDepartmentName(const QString &newDepartmentName);

    QString getParentDepartmentId() const;
    void setParentDepartmentId(const QString &newParentDepartmentId);

    int getRow() const;
    void setRow(int newRow);

signals:
    void IdChanged();

    void DepartmentIdChanged();

    void DepartmentNameChanged();

    void ParentDepartmentIdChanged();

    void RowChanged();

private:
    int Id;
    QString DepartmentId;
    QString DepartmentName;
    QString ParentDepartmentId;
    int Row;
    Q_PROPERTY(int Id READ getId WRITE setId NOTIFY IdChanged FINAL)
    Q_PROPERTY(QString DepartmentId READ getDepartmentId WRITE setDepartmentId NOTIFY DepartmentIdChanged FINAL)
    Q_PROPERTY(QString DepartmentName READ getDepartmentName WRITE setDepartmentName NOTIFY DepartmentNameChanged FINAL)
    Q_PROPERTY(QString ParentDepartmentId READ getParentDepartmentId WRITE setParentDepartmentId NOTIFY ParentDepartmentIdChanged FINAL)
    Q_PROPERTY(int Row READ getRow WRITE setRow NOTIFY RowChanged FINAL)
};

#endif // DEPARTMENT_H
