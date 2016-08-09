#include <QApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>

#include "settings.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    Settings* settings = new Settings();
    engine.rootContext()->setContextProperty("settings", settings);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
