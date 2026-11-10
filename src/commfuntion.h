#ifndef COMMFUNTION_H
#define COMMFUNTION_H
#include <QDateTime>
#include <QString>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QFile>
#include <QProcess>
#include <fstream>
#include <QRegularExpression>   //正则规则，用于检验IP、MAC
#include <QList>
#include <cctype>
#include <algorithm>
#include <sys/stat.h>
#include <iostream>
using namespace std;
#define PROGRAM_CONF_PATH "conf/"
#define INIPATH PROGRAM_CONF_PATH"computer.ini"
#define PORTPATH PROGRAM_CONF_PATH"portmsg.ini"

// 声明要调用的函数原型
typedef std::string (*Getresultbyroot)(const char* srccmdstr);
typedef int (*Execcmdbyroot)(const char* srccmdstr);
// vbox
typedef std::string (*Getvmsname)();//获取虚拟机名称
typedef bool (*Getvmsrunstatus)(std::string machinename);//获取虚拟机的启动状态


class CommFuntion
{
public:
    CommFuntion();
    qint64 getcurtime();//获取当前时间戳
    qint64 gettimebydatestr(QString dateString);//通过日期字符串获取时间戳
    QString getqstrDateTime();//获取当前时间的日期字符串
    QString getdatestrbytime(qint64 timestamp);//通过时间戳获取日期字符串
    bool isValidIPAddress(const QString &ipAddress);//判断字符串是否为IP地址
    bool isValidMacAddress(const QString& mac);//判断字符串是否为MAC地址
    void copyFilebycmd(const QString &srcFilePath, const QString &dstFilePath);//文件拷贝
    void gethostNetworkIP(QMap<QString,QString>& hostIp);//获取宿主机的所有IP地址
    QString base64Encode(const QString &input) ;
    QString base64Decode(const QString &input) ;
    time_t getFileModifiedTime(const char* filePath);
    bool fileExists(const std::string& fileName);//检查指定文件是否存在

    //与root交互
    bool execrootcmd(const char* cmdstr);
    std::string Getresultbyrootcmd(const char* cmdstr);

    bool checksqlonline(const std::string ip,int port);
};

#endif // COMMFUNTION_H
