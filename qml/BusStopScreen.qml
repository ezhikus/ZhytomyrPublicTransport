import QtQuick 2.0
import "API.js" as API

Rectangle {
    id: rectangle2
    width: 480
    height: 800
    property int busStopId
    property string busStopName

    Header {
        id: busStopHeader
        function onRefreshButtonClicked() {
            API.updateBusStopInfo()
        }
    }

    Text {
        id: busStopNameLabel
        text: busStopName
        anchors.top: busStopHeader.bottom
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 20
    }

    ListView {
        id: view
        x: 0
        y: 10
        anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.margins: 10
        model:  ListModel {
            id: busStopInfo
        }

        delegate: Item {
            width: 80
            height: 100
            Row {
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

