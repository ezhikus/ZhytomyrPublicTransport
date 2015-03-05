import QtQuick 2.0
import "API.js" as API

Rectangle {
    id: rectangle2
    width: 480
    height: 800

    Column {
        id: column1
        anchors.fill: parent
        Header {
            function onRefreshButtonClicked() {
                API.updateBusStopInfo()
            }
        }

        Rectangle {
            id: rectangle1
            height: parent.height / 10 * 4
            width: parent.width
            ListView {
                id: view
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
    }
}

