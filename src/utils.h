#ifndef UTILS_H
#define UTILS_H

#include <QString>
#include <QUuid>
#include <QCryptographicHash>
#include <QDebug>
#include "qaesencryption.h"

class Utils
{
public:
    Utils();


    QString getUUid();

    QString encodedText(QString data);
    QString decodedText(QString data);

private:
    QString key = "9876543";
};

#endif // UTILS_H
