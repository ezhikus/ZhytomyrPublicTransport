import QtQuick 2.0
import QtQuick.Controls 1.2

import "API.js" as API
import "UI.js" as UI

Rectangle {
    width: UI.UI.width
    height: UI.UI.height
    property bool isInitialized : false

    Column {
        anchors.fill: parent

        Component.onCompleted: {
            if (isInitialized == false) {
                API.updateTransportInfo();
                isInitialized = true;
            }
        }

        Header {
            leftButtonSource: '../res/ic_close_white_48dp.png'
            function onBackButtonClicked() {
                Qt.quit()
            }

            function onRefreshButtonClicked() {
                API.updateTransportInfo()
            }
        }

        Text {
            id: busesLabel
            text: qsTr("Маршрутки")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: parent.height / 20
        }

        Rectangle {
            id: buses
            height: parent.height / 10 * 4
            width: parent.width


            Flow {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 5

                Repeater {
                    model: ListModel {
                        id: busesList
                    }
                    Button {
                        text: shortName
                        onClicked: {
                            var routeScreen = Qt.resolvedUrl("RouteScreen.qml")
                            mainStackView.push({
                                            item:routeScreen,
                                            properties:{
                                                       routeId: id,
                                                       routeShortName: shortName,
                                                       routeName: name
                                            }
                            })
                        }
                    }
                }
            }
        }

        Text {
            id: trolleyBusesLabel
            text: qsTr("Тролейбуси")
            font.pixelSize: parent.height / 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: trolleyBuses
            height: parent.height / 10 * 4
            width: parent.width

            Flow {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 5

                Repeater {
                    model: ListModel {
                        id: trolleybusesList
                    }
                    Button {
                        text: shortName
                        onClicked: {
                            mainStackView.push(Qt.resolvedUrl("RouteScreen.qml"))
                        }
                    }
                }
            }
        }
    }
}

