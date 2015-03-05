import QtQuick 2.0
import "API.js" as API

Rectangle {
    width: 480
    height: 800

    Column {
        id: column1
        anchors.fill: parent

        Header {
            function onRefreshButtonClicked() {
                API.updateRouteInfo()
            }
        }

        Rectangle {
            height: parent.height / 10 * 4
            width: parent.width
            ListView {
                id: view
                anchors.margins: 10
                anchors.fill: parent
                model:  ListModel {
                    id: routeInfo
                }

                delegate: Item {
                    width: 80
                    height: 100
                    Row {
                        id: row1
                        Rectangle {
                            width: 40
                            height: 80
                            color: "blue"
                        }

                        Text {
                            text: stopName
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }
            }
        }
    }
}

