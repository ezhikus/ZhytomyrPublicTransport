import QtQuick 2.0
import "API.js" as API
import "UI.js" as UI

Rectangle {
    id: bustStopScreen
    width: UI.UI.width
    height: UI.UI.height

    property string routeShortName: ""
    property string busStopParamString
    property string busStopName

    property bool initialized: false

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
        initialized = true;
    }

    Component.onCompleted: {
        if (initialized === false)
            bustStopScreen.callUpdate();
    }

    Connections {
         target: header
         onRightButtonClicked: {
             if (mainStackView.currentItem === bustStopScreen)
                bustStopScreen.callUpdate();
         }
    }

    Text {
        id: routeShortNameLabel
        text: "№ " + routeShortName
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: bustStopScreen.width / 10
        font.bold: true
    }

    Text {
        id: busStopNameLabel
        text: busStopName
        anchors.top: routeShortNameLabel.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: bustStopScreen.width / 12
    }

    Text {
        id: noTransportLabel
        text: "Від кінцевої зупинки до вашої на цьому маршруті транспорту зараз немає"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        font.pixelSize: bustStopScreen.width / 20
        font.bold: true
        wrapMode: Text.WordWrap
        horizontalAlignment : Text.AlignHCenter
        height: 400
        visible: false
    }

    ListView {
        id: view
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 100
        anchors.verticalCenter: parent.verticalCenter
        anchors.top: busStopNameLabel.bottom
        anchors.margins: 10
        model:  ListModel {
            id: busStopInfo
        }

        delegate: Item {
            height: 100
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    property bool isItNearest: index === 0
                    text: "До " + (isItNearest ? "прибуття" : "наступного") + ": " + Math.floor(arrivalTime / 60).toString() + " хв " + Math.floor(arrivalTime % 60).toString() + " сек"
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: isItNearest ? bustStopScreen.width / 20 : bustStopScreen.width / 25
                    font.bold: isItNearest
                }
            }
        }
    }
}
