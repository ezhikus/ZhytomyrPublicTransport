TEMPLATE = app

QT += qml quick widgets

SOURCES += \
    src/main.cpp

RESOURCES += \
    qml/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    qml/main.qml \
    qml/StartScreen.qml \
    qml/SelectTransportScreen.qml \
    qml/RouteScreen.qml \
    qml/BusStopScreen.qml \
    qml/API.js \
    qml/Header.qml
