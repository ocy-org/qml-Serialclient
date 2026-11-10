#include "commfuntion.h"
#include <QDebug>

CommFuntion::CommFuntion() {}


QString CommFuntion::getqstrDateTime(){
    // 获取当前日期时间
    QDateTime currentDateTime = QDateTime::currentDateTime();
    // 将当前日期时间转换为 QString
    QString dateTimeString = currentDateTime.toString("yyyy-MM-dd hh:mm:ss");

    return dateTimeString;
}

qint64 CommFuntion::getcurtime(){
    // 获取当前时间
    QDateTime currentDateTime = QDateTime::currentDateTime();
    // 获取当前时间戳（秒数）
    qint64 timestamp = currentDateTime.toSecsSinceEpoch();
    return timestamp;
}

QString CommFuntion::getdatestrbytime(qint64 timestamp){
    // 使用 QDateTime::fromSecsSinceEpoch 将时间戳转换为 QDateTime 对象
    QDateTime dateTime = QDateTime::fromSecsSinceEpoch(timestamp);

    // 将 QDateTime 格式化为日期字符串
    QString formattedDate = dateTime.toString("yyyy-MM-dd hh:mm:ss");
    return formattedDate;
}

qint64 CommFuntion::gettimebydatestr(QString dateString){
    // 将日期字符串转换为QDateTime对象
    QDateTime dateTime = QDateTime::fromString(dateString, "yyyy-MM-dd hh:mm:ss");

    if(dateTime.isValid()) {
        // 获取时间戳（以秒为单位）
        qint64 timestamp = dateTime.toSecsSinceEpoch();
        return timestamp;
    } else {
        printf("Invalid date string!");
    }

    return 0;
}

bool CommFuntion::isValidIPAddress(const QString &ipAddress)
{
    QRegularExpression ipRegex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$");
    return ipRegex.match(ipAddress).hasMatch();
}

bool CommFuntion::isValidMacAddress(const QString &mac)
{
    // 正则表达式匹配 MAC 地址（包括 : 和 - 作为分隔符）
    QRegularExpression macRegex("([0-9A-Fa-f]{2}[-:]){5}[0-9A-Fa-f]{2}");
    QRegularExpressionMatch match = macRegex.match(mac);
    return match.hasMatch();
}

void CommFuntion::copyFilebycmd(const QString &srcFilePath, const QString &dstFilePath)
{
    QStringList args;
    args << "-f" << srcFilePath << dstFilePath;

    QProcess process;
    process.start("cp", args);
    process.waitForFinished(-1);

    qDebug() << "Exit code:" << process.exitCode();
    qDebug() << "Error:" << process.errorString();
}


void CommFuntion::gethostNetworkIP(QMap<QString,QString>& hostIp){

}

QString CommFuntion::base64Encode(const QString &input) {
    QByteArray byteArray = input.toUtf8(); // 转换为 UTF-8
    return byteArray.toBase64();           // Base64 编码
}

QString CommFuntion::base64Decode(const QString &input) {
    QByteArray byteArray = QByteArray::fromBase64(input.toUtf8()); // Base64 解码
    return QString::fromUtf8(byteArray);                           // 转换为 QString
}

time_t CommFuntion::getFileModifiedTime(const char* filePath) {
    struct stat fileInfo;
    if (stat(filePath, &fileInfo) != 0) {
        // 获取文件信息失败
        return -1;
    }
    return fileInfo.st_mtime;  // 返回文件的最后修改时间
}

#include <sys/stat.h>
bool CommFuntion::fileExists(const std::string& fileName) {
    struct stat buffer;
    return (stat(fileName.c_str(), &buffer) == 0); // 0 means the file exists
}


bool CommFuntion::checksqlonline(const std::string ip,int port){
    return true;
}


bool CommFuntion::execrootcmd(const char* cmdstr){
    return true;
}

std::string CommFuntion::Getresultbyrootcmd(const char* cmdstr){
    return "OK";
}

