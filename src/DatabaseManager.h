#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QSqlDatabase>
#include <QSqlError>
#include <QDebug>
#include <QSettings>

#include <sstream>
#include <string>
#include <iostream>

#include "commfuntion.h"


typedef std::string (*Decode_file)(std::string Encode_filename,const char key);

class DatabaseManager
{
public:
    static DatabaseManager& getInstance()
    {
        static DatabaseManager instance;
        return instance;
    }

    QSqlDatabase getDatabaseConnection(QString dbIP)
    {
        if (!m_db.isValid()) {
            // 在添加数据库连接之前先关闭同名连接
            if (QSqlDatabase::contains("qt_sql_default_connection")) {
                QSqlDatabase::removeDatabase("qt_sql_default_connection");
            }
            m_db = QSqlDatabase::addDatabase("QMYSQL");
            m_db.setDatabaseName("mydatabase");
            m_db.setUserName("admin");
            m_db.setPassword("123456");
            m_db.setHostName(dbIP);
            if (!m_db.open()) {
                qDebug() << "Failed to connect to MySQL:" << m_db.lastError().text();
                std::cout << __FUNCTION__ << "mysql Failed " << m_db.lastError().text().toStdString()<<std::endl;
                m_db.close();
                m_db =  QSqlDatabase();
            }else{
                // std::cout << "serverIp" << serverIp.toStdString()<<std::endl;
            }
        }else{
            // std::cout << "not valid:"<<std::endl;
        }
        return m_db;
    }

    void closeDataBase(){
        if(m_db.isOpen()){
            std::cout << "close db:"<<std::endl;
            // m_db.close();
            // m_db =  QSqlDatabase();
            QString name;
            {
                name = QSqlDatabase::database().connectionName();
            }//超出作用域，隐含对象QSqlDatabase::database()被删除。
            QSqlDatabase::removeDatabase(name);
        }
    }

private:
    QSqlDatabase m_db;

    // 私有构造函数和析构函数，确保单例模式
    DatabaseManager() {}
    ~DatabaseManager() {}
};


#endif // DATABASEMANAGER_H
