#ifndef SERIALSERVICE_H
#define SERIALSERVICE_H

#include <QVariant>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QObject>
#include <QProcess>
#include <QByteArray>

#include <iostream>
#include <cstdio>
#include <string>
#include <cstring>
#include <stdio.h>
#include <string.h>

#include <sstream>
#include "commfuntion.h"
#define SP_LEN 3
class SerialService : public QObject
{
    Q_OBJECT
public:
    SerialService();


    Q_INVOKABLE QVariantList getNormalPort();
    Q_INVOKABLE QVariant sendAndReceiveMsg(const QVariant Msg);
    Q_INVOKABLE void sendToLp(const QVariant portName);
    Q_INVOKABLE QVariant ping(const QVariant ip);
    Q_INVOKABLE QVariant checkvboxstatus();

    void SendHexData(const char* sendbuf);
    QString recvserialdata();
    QString intToHexString(int value);
    void DataReceived();


signals:
    void putReceviceData(QVariant data);
public slots:
    int openPort(const QVariant portName,const QVariant rate,const QVariant status);
private:
    QSerialPort *serialPort;
    CommFuntion comfun;
};

#endif // SERIALSERVICE_H
