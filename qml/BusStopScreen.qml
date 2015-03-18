import QtQuick 2.0
import "API.js" as API
import "UI.js" as UI

Rectangle {
    id: bustStopScreen
    width: UI.UI.width
    height: UI.UI.height
    property string busStopParamString
    property string busStopName

    property bool initialized: false

    Component.onCompleted: {
        if (initialized === false) {
            API.updateBusStopInfo(busStopParamString);
            initialized = true;
        }
    }

    Header {
        id: busStopHeader
        function onBackButtonClicked() {
            mainStackView.pop()
        }

        function onRefreshButtonClicked() {
            API.updateBusStopInfo(busStopParamString)
        }
    }

    Text {
        id: busStopNameLabel
        text: busStopName
        anchors.top: busStopHeader.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: parent.height / 30
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
                    font.pixelSize: isItNearest ? bustStopScreen.height / 25 : bustStopScreen.height / 30
                    font.bold: isItNearest
                }
            }
        }
    }
}
