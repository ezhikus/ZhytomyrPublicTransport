import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

import "API.js" as API
import "Settings.js" as Settings

Rectangle {
    id: selectTransportScreen

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
                font.pixelSize: selectTransportScreen.height * 0.1
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

    function onHashSumReceived(hashSum) {
        var cachedHashsum = Settings.getCachedTransportInfoHashsum();
        if (cachedHashsum.length > 0 && cachedHashsum === hashSum) {
            processCurrentTransportInfo(Settings.getCachedTransportInfo());
        } else {
            fileDownloader.transportInfoReceived.connect(processCurrentTransportInfo);
            fileDownloader.transportInfoError.connect(onTransportInfoError);
            fileDownloader.getTransportInfo(API.apiEndpoints.transportInfoURL);
        }
    }

    function onHashSumError() {
        console.log("Hashsum Error");
    }

    function onTransportInfoError() {
        console.log("Data Error");
    }

    function processCurrentTransportInfo(transportInfo) {
        Settings.setCachedTransportInfo(transportInfo);
        Settings.setCachedTransportInfoHashsum(transportInfo.substring(0, 1000));

        var buses = [];
        var trolleybusses = [];
        var data = JSON.parse(transportInfo)
        for (var i = 0; i < data.data.length; ++i) {
            if (data.data[i]["inf"] === "{1}" && data.data[i]["sNm"].length !== 0) {
                buses.push({shortName: data.data[i]["sNm"],
                                  name: data.data[i]["nm"],
                                  id: data.data[i]["id"]});
            } else if (data.data[i]["inf"] === "{2}" && data.data[i]["sNm"].length !== 0) {
                trolleybusses.push({shortName: data.data[i]["sNm"],
                                  name: data.data[i]["nm"],
                                  id: data.data[i]["id"]});
            }
        }
    }

    function updateTransportInfo() {
        fileDownloader.hashSumReceived.connect(onHashSumReceived);
        fileDownloader.hashSumError.connect(onHashSumError);
        fileDownloader.getHashsum(API.apiEndpoints.transportInfoURL);
    }


    function callUpdate() {
        header.state = "Updating";
        //dataUpdateWorker.sendMessage({'url' : API.apiEndpoints.transportInfoURL})
        updateTransportInfo();
    }

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

