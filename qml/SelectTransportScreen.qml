import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

import "API.js" as API
import "UI.js" as UI

Rectangle {
    id: selectTransportScreen
    anchors.fill: parent

    WorkerScript {
       id: dataUpdateWorker
       source: "Worker.js"
       onMessage: {
           if (messageObject.type === 'fail') {
               mainStackView.pop()
               header.state = "Normal"
               mainStackView.push(Qt.resolvedUrl("UpdateDataScreen.qml"))
               mainStackView.currentItem.state = "ConnectionError"
           }
           if (messageObject.type === 'clear') {
               busesList.clear()
               trolleybusesList.clear()
           } else if(messageObject.type === 'addBus') {
                busesList.append({
                                     id: messageObject.id,
                                     name: messageObject.name,
                                     shortName: messageObject.shortName
                                 })
           }else if (messageObject.type === 'addTrolleybus') {
               trolleybusesList.append({
                                    id: messageObject.id,
                                    name: messageObject.name,
                                    shortName: messageObject.shortName
                                })
           }else if (messageObject.type === 'updateCompleted') {
               mainStackView.pop()
               header.state = "Normal"
           }
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

        Column {
            property alias groupLabelText: groupLabel.text
            property alias buttonsCreateRepeaterModel: buttonsCreateRepeater.model
            property double groupWidthCoef: 1

            Text {
                id: groupLabel
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: selectTransportScreen.height
            }

            Rectangle {
                id: groupRectangle
                height: 0.42 * selectTransportScreen.height
                width: 0.94 * selectTransportScreen.width

                Flow {
                    anchors.fill: parent
                    anchors.margins: 0
                    spacing: 0

                    Repeater {
                        id: buttonsCreateRepeater
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

    function callUpdate() {
        header.state = "Updating";
        dataUpdateWorker.sendMessage({'url' : API.apiEndpoints.transportInfoURL})
    }

    Rectangle {
        anchors.fill: parent

        Component.onCompleted: {
            selectTransportScreen.callUpdate()
        }

        GridLayout {
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: parent.width * 0.05
            rowSpacing: parent * 0.03
            columnSpacing: parent.width * 0.03
            flow:  GridLayout.TopToBottom

            Loader {
                sourceComponent: transportGroup;
                onLoaded: {
                    item.groupLabelText = qsTr("Маршрутки")
                    item.buttonsCreateRepeaterModel = busesList
                }
            }

            Loader {
                sourceComponent: transportGroup;
                onLoaded: {
                    item.groupLabelText = qsTr("Тролейбуси")
                    item.buttonsCreateRepeaterModel = trolleybusesList
                    item.groupWidthCoef = 0.7
                }
            }
        }
    }
}

