import QtQuick 2.0
import QtQuick.Layouts 1.1

import "API.js" as API

Rectangle {
    id: bustStopScreen

    property string routeShortName: "37"
    property string busStopId
    property string busStopName: "Тест тест тест тест"

    function callUpdate() {
        header.state = "Updating";
        noTransportLabel.visible = false;
        API.updateBusStopInfo(busStopId,
            function() {
                header.state = "Normal";
                if (busStopInfo.count == 0)
                    noTransportLabel.visible = true;
            },
            function() {
                /*TODO: show FAIL display*/
            });
    }

    Component.onCompleted: {
        bustStopScreen.callUpdate();
    }

    Column {
        id: column1
        anchors.fill: parent

        Text {
            text: "№ " + routeShortName
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: bustStopScreen.height * 0.1
            font.bold: true
        }

        Text {
            id: busStopLabel
            text: busStopName
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: parent.width * 0.065
        }

        Text {
            id: noTransportLabel
            text: "Від кінцевої зупинки до даної на цьому маршруті транспорту зараз немає"
            height: parent.height * 0.6
            verticalAlignment: Text.AlignVCenter
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: bustStopScreen.height * 0.05
            font.bold: true
            wrapMode: Text.WordWrap
            horizontalAlignment : Text.AlignHCenter
            visible: false
        }

        ListView {
            height: parent.height * 0.6
            spacing: height / (count * 2)
            anchors.top: busStopLabel.bottom
            anchors.topMargin: bustStopScreen.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            model:  ListModel {
                id: busStopInfo
            }

            delegate: Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        property bool isItNearest: index === 0
                        text: "До " + (isItNearest ? "прибуття" : "наступного") + ": " + arrivalTime + " хв "
                        font.pixelSize: bustStopScreen.height * 0.04
                        font.bold: isItNearest
                      }
        }
    }
}
