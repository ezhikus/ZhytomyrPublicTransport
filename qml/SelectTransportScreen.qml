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
            leftButtonText: qsTr("Вихід")

            function onBackButtonClicked() {
                Qt.quit()
            }

            function onRefreshButtonClicked() {
                mainStackView.push(Qt.resolvedUrl("UpdateDataScreen.qml"))
                API.updateTransportInfo()
            }
        }

        ListModel {
            id: busesList
        }

        ListModel {
            id: trolleybusesList
        }

        Component {
            id: transportGroup

            Rectangle {
                property string transportGroupTitle: "Title"
                Text {
                    id: busesLabel
                    text: transportGroupTitle
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
                            model: busesList
                            Button {
                                text: shortName
                                onClicked: {
                                    var routeScreen = Qt.resolvedUrl("RouteScreen.qml")
                                    mainStackView.push({
                                                    item:routeScreen,
                                                    properties:{
                                                               routeId: id,
                                                               routeShortName: shortName,
                                                               routeName: name
                                                    }
                                    })
                                }
                            }
                        }
                    }
                }
            }
        }

        Loader {
            id: loader
            sourceComponent: transportGroup;
            onStatusChanged: {
                if (loader.status == Loader.Ready)
                    item.transportGroupTitle = "Маршрутки"
            }
        }

        Text {
            id: trolleyBusesLabel
            text: qsTr("Тролейбуси")
            font.pixelSize: 25
            anchors.horizontalCenter: parent.horizontalCenter
        }

        /*Rectangle {
            id: trolleyBuses
            height: parent.height / 10 * 4
            width: parent.width

            Flow {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 5

                Repeater {
                    model:trolleybusesList
                    Button { text: shortName }
                }
            }
        }*/
    }
}

