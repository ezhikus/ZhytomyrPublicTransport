import QtQuick 2.0
import QtQuick.Controls 1.2
import "API.js" as API

Rectangle {
    width: 480
    height: 800
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
            font.pixelSize: 25
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
                    Button { text: shortName }
                }
            }
        }

        Text {
            id: trolleyBusesLabel
            text: qsTr("Тролейбуси")
            font.pixelSize: 25
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
                    Button { text: shortName }
                }
            }
        }
    }
}

