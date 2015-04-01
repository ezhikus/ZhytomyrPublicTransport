import QtQuick 2.0
import QtQuick.Layouts 1.1

import "API.js" as API
import "UI.js" as UI

Rectangle {
    id: bustStopScreen
    width: UI.UI.width
    height: UI.UI.height

    property string routeShortName: ""
    property string busStopParamString
    property string busStopName

    function callUpdate() {
        header.state = "Updating";
        noTransportLabel.visible = false;
        API.updateBusStopInfo(busStopParamString,
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
        anchors.fill: parent

        Text {
            text: "№ " + routeShortName
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: bustStopScreen.width * 0.1
            font.bold: true
        }

        Text {
            text: busStopName
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: bustStopScreen.width * 0.09
        }

        Text {
            id: noTransportLabel
            text: "Від кінцевої зупинки до вашої на цьому маршруті транспорту зараз немає"
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: bustStopScreen.width * 0.05
            font.bold: true
            wrapMode: Text.WordWrap
            horizontalAlignment : Text.AlignHCenter
            visible: false
        }

        ListView {
            id: view
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: bustStopScreen.height * 0.15
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins:  bustStopScreen.height * 0.01
            model:  ListModel {
                id: busStopInfo
            }

            delegate: Item {
                height: bustStopScreen.height * 0.15
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        property bool isItNearest: index === 0
                        text: "До " + (isItNearest ? "прибуття" : "наступного") + ": " + Math.floor(arrivalTime / 60).toString() + " хв " + Math.floor(arrivalTime % 60).toString() + " сек"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: isItNearest ? bustStopScreen.width * 0.05 : bustStopScreen.width * 0.04
                        font.bold: isItNearest
                    }
                }
            }
        }
    }
}
