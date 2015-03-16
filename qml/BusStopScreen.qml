import QtQuick 2.0
import "API.js" as API
import "UI.js" as UI

Rectangle {
    id: rectangle2
    width: UI.UI.width
    height: UI.UI.height
    property int busStopId
    property string busStopName

    property bool initialized: false

    Component.onCompleted: {
        if (initialized === false) {
            API.updateBusStopInfo(busStopId);
            initialized = true;
        }
    }

    Header {
        id: busStopHeader
        function onBackButtonClicked() {
            mainStackView.pop()
        }

        function onRefreshButtonClicked() {
            API.updateBusStopInfo(busStopId)
        }
    }

    Text {
        id: busStopNameLabel
        text: busStopName
        anchors.top: busStopHeader.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: parent.height / 40
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
                id: row1
                Text {
                    text: "До " + (index === 0 ? "найближчої" : "наступної") + " маршрутки: "
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    text: Math.floor(arrivalTime / 60).toString() + " хв " + Math.floor(arrivalTime % 60).toString() + " сек"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
