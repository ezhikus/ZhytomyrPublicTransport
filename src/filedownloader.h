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
  QString getTransportInfo(QUrl url);

 signals:
  void hashSumErrorSignal();
  void hashSumReceived(QString hashSum);

 private slots:
  void hashSumError(QNetworkReply::NetworkError err);
  void hashSumUpdateProgress(qint64 read, qint64 total);

 private:
  QNetworkAccessManager m_WebCtrl;
  QNetworkReply *reply;
};

Q_DECLARE_METATYPE(FileDownloader*)

#endif // FILEDOWNLOADER_H
