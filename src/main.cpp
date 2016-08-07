#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include "settings.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    Settings* settings = new Settings("Zhytomyr", "PublycTransport");

    engine.rootContext()->setContextProperty("settings", settings);

    return app.exec();
}
