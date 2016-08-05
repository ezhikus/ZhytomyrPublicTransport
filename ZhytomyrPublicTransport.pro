TEMPLATE = app

QT += qml quick widgets

SOURCES += \
    src/main.cpp \
    src/settings.cpp

RESOURCES += \
    qml/qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    qml/main.qml \
    qml/SelectTransportScreen.qml \
    qml/RouteScreen.qml \
    qml/BusStopScreen.qml \
    qml/API.js \
    qml/Header.qml \
    qml/UpdateDataScreen.qml \
    qml/UI.js \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    qml/Worker.js \
    qml/Settings.js

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    src/settings.h
