#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
 #include <QNetworkProxy>

#include "settings.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //QNetworkProxy proxy(QNetworkProxy::HttpProxy, "127.0.0.1", 8888);
    //QNetworkProxy::setApplicationProxy(proxy);

    QQmlApplicationEngine engine;
    Settings* settings = new Settings();
    engine.rootContext()->setContextProperty("settings", settings);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
