import QtQuick 2.0
import QtQuick.Controls 1.2
import "API.js" as API

Rectangle {
    id: routeScreen
    width: 480
    height: 800

    property int routeId: -1
    property string routeShortName: ""
    property string routeName: ""
    property bool initialized: false

    Column {
        anchors.fill: parent

        Component.onCompleted: {
            if (initialized === false) {
                API.updateRouteInfo();
                initialized = true;
            }
        }

        Header {
            function onBackButtonClicked() {
                mainStackView.pop()
            }

            function onRefreshButtonClicked() {
                API.updateRouteInfo()
            }
        }

        Text {
            id: routeNumberLabel
            text: qsTr("№") + routeShortName
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 35
        }

        Text {
            id: text1
            text: routeName
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20
        }

        Rectangle {
            width: parent.width
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
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
                            width: parent.width
                            height: 80
                            color: "blue"

                            Button {
                                text : "test"
                            }
                        }
                    }
                }
            }
        }
    }
}

