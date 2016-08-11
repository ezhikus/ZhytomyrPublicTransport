#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QNetworkProxy>

#include "settings.h"
#include "filedownloader.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //QNetworkProxy proxy(QNetworkProxy::HttpProxy, "127.0.0.1", 8888);
    //QNetworkProxy::setApplicationProxy(proxy);

    QQmlApplicationEngine engine;
    Settings* settings = new Settings();
    FileDownloader* fileDownloader = new FileDownloader();

    engine.rootContext()->setContextProperty("settings", settings);
    engine.rootContext()->setContextProperty("fileDownloader", fileDownloader);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
