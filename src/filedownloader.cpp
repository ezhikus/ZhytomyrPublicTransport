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
    QNetworkRequest request = prepareNetworkRequest(url);
    reply = m_WebCtrl.get(request);

    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)),
                this, SLOT(hashSumError(QNetworkReply::NetworkError)));
    connect(reply, SIGNAL(downloadProgress(qint64, qint64)),
                this, SLOT(hashSumUpdateProgress(qint64, qint64)));
}

void FileDownloader::hashSumError(QNetworkReply::NetworkError err)
{
    reply->deleteLater();
    emit hashSumError();
}

void FileDownloader::hashSumUpdateProgress(qint64 read, qint64 total)
{
   if (read < 1000)
       return;

   QByteArray hashSumBinary = reply->read(2000);
   QString hashSumStr = QString::fromUtf8(hashSumBinary).left(1000);

   emit hashSumReceived(hashSumStr);
   reply->abort();
}

void FileDownloader::getTransportInfo(QUrl url)
{
    QNetworkRequest request = prepareNetworkRequest(url);
    reply2 = m_WebCtrl.get(request);

    connect(reply2, SIGNAL(error(QNetworkReply::NetworkError)),
                this, SLOT(transportInfoError(QNetworkReply::NetworkError)));
    connect(reply2, SIGNAL(finished()),
                this, SLOT(getTransportInfoFinished()));
}

void FileDownloader::transportInfoError(QNetworkReply::NetworkError err)
{
    reply2->deleteLater();
    emit transportInfoError();
}

void FileDownloader::getTransportInfoFinished()
{
    QByteArray data = reply2->readAll();
    QString transportInfoStr = QString::fromUtf8(data);

    if (transportInfoStr.length() > 0)
    {
        emit transportInfoReceived(transportInfoStr);
    }

    reply2->deleteLater();
}

QNetworkRequest FileDownloader::prepareNetworkRequest(QUrl url)
{
    QNetworkRequest request(url);
    QList<QNetworkCookie> cookieList;

    QUuid guid = QUuid::createUuid();
    QString guidStr = guid.toString();
    guidStr = guidStr.mid(1, guidStr.length() - 2);

    cookieList.append(QNetworkCookie("gts.web.uuid", guidStr.toUtf8()));
    cookieList.append(QNetworkCookie("gts.web.city", "zhytomyr"));
    request.setHeader(QNetworkRequest::CookieHeader, QVariant::fromValue(cookieList));

    return request;
}
