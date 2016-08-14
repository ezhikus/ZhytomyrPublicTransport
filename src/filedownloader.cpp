#include "filedownloader.h"

#include <QUuid>
#include <QNetworkCookie>

FileDownloader::FileDownloader(QObject *parent) :
 QObject(parent)
{
    reply = NULL;
}

FileDownloader::~FileDownloader() { }

void FileDownloader::getHashsum(QUrl url) {
    QNetworkRequest request(url);
    QList<QNetworkCookie> cookieList;

    QUuid guid = QUuid::createUuid();
    QString guidStr = guid.toString();
    guidStr = guidStr.mid(1, guidStr.length() - 2);

    cookieList.append(QNetworkCookie("gts.web.uuid", guidStr.toUtf8()));
    cookieList.append(QNetworkCookie("gts.web.city", "zhytomyr"));
    request.setHeader(QNetworkRequest::CookieHeader, QVariant::fromValue(cookieList));

    reply = m_WebCtrl.get(request);

    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)),
                this, SLOT(hashSumError(QNetworkReply::NetworkError)));
    connect(reply, SIGNAL(downloadProgress(qint64, qint64)),
                this, SLOT(hashSumUpdateProgress(qint64, qint64)));
}

void FileDownloader::hashSumError(QNetworkReply::NetworkError err)
{
    reply->deleteLater();
    emit hashSumErrorSignal();
}

void FileDownloader::hashSumUpdateProgress(qint64 read, qint64 total)
{
   if (read < 1000)
       return;

   QByteArray hashSumBinary = reply->read(1000);
   QString hashSumStr = QString::fromUtf8(hashSumBinary);

   emit hashSumReceived(hashSumStr);
   reply->abort();
}

QString FileDownloader::getTransportInfo(QUrl url) {
    return "";
}
