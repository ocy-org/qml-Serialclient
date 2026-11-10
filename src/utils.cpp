#include "utils.h"

Utils::Utils() {}


QString Utils::getUUid(){
    // 生成一个新的 UUID
    QUuid uuid = QUuid::createUuid();
    QString temp = uuid.toString();
    return temp.replace("{","").replace("}","").replace("-","");
}

QString Utils::encodedText(QString data)
{
    //密钥长度AES_128,加密方式ECB,填充方式ZERO
    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB, QAESEncryption::ZERO);
    QByteArray hashKey = QCryptographicHash::hash(key.toUtf8(), QCryptographicHash::Md5);
    QByteArray encodedText = encryption.encode(data.toUtf8(), hashKey);
    QString encodeTextStr = QString::fromLatin1(encodedText.toBase64());
    return encodeTextStr;
}


//使用AES对数据进行解密
QString Utils::decodedText(QString data)
{
    //密钥长度AES_128,加密方式ECB,填充方式ZERO
    QAESEncryption encryption(QAESEncryption::AES_128, QAESEncryption::ECB,QAESEncryption::ZERO);
    QByteArray hashKey = QCryptographicHash::hash(key.toUtf8(), QCryptographicHash::Md5);
    QByteArray decodedText = encryption.decode(QByteArray::fromBase64(data.toLatin1()), hashKey);
    QString decodedTextStr = QString::fromLatin1(decodedText);
    return decodedTextStr;
}
