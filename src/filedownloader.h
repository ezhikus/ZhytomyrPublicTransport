#ifndef FILEDOWNLOADER_H
#define FILEDOWNLOADER_H

#include <QObject>
#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

class FileDownloader : public QObject
{
 Q_OBJECT
 public:
  explicit FileDownloader(QObject *parent = 0);
  virtual ~FileDownloader();

  Q_INVOKABLE
  void getHashsum(QUrl url);

  Q_INVOKABLE
  void getTransportInfo(QUrl url);

 signals:
  void hashSumError();
  void hashSumReceived(QString hashSum);

  void transportInfoError();
  void transportInfoReceived(QString transportInfo);

 private slots:
  void hashSumError(QNetworkReply::NetworkError err);
  void hashSumUpdateProgress(qint64 read, qint64 total);

  void transportInfoError(QNetworkReply::NetworkError err);
  void getTransportInfoFinished();

 private:
  QNetworkRequest prepareNetworkRequest(QUrl url);

  QNetworkAccessManager m_WebCtrl;
  QNetworkReply *reply;
  QNetworkReply *reply2;
};

Q_DECLARE_METATYPE(FileDownloader*)

#endif // FILEDOWNLOADER_H
