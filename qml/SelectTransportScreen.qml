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

    function guid() {
      function s4() {
        return Math.floor((1 + Math.random()) * 0x10000)
          .toString(16)
          .substring(1);
      }
      return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
        s4() + '-' + s4() + s4() + s4();
    }

    Connections {
            target: fileDownloader
            /*hashSumErrorSignal: function() {
                console.log("hashSumErrorSignal");
            }*/
            /*onHashSumReceived: function(hashSum) {
                console.log("hashSum: " + hashSum);
            }*/
    }

    function onHashSumReceived(hashSum) {
                    console.log("hashSum: " + hashSum);
                }

    function makeRequst(requestUrl, okCallback, errCallback) {
        fileDownloader.hashSumReceived.connect(onHashSumReceived);
        fileDownloader.getHashsum(requestUrl);
        /*if (Settings.getCachedTransportInfoHashsum() === hashSum){
            okCallback(Settings.getCachedTransportInfo());
        }else {
            var transportInfo = fileDownloader.getTransportInfo(requestUrl);
            if (transportInfo.size() > 0) {
                Settings.setCachedTransportInfoHashsum(transportInfo.left(1000));
                Settings.setCachedTransportInfo(transportInfo);
                okCallback(transportInfo);
            } else {
                errCallback("");
            }
        }

        doc.open("GET", request)
        var cookieValue = "gts.web.uuid=" + guid() + "; gts.web.city=zhytomyr";
        doc.setRequestHeader("Cookie:", cookieValue);
        doc.setRequestHeader("Accept-Encoding:", "identity");
        doc.send()*/
    }

    /*function makeForcedRequest(request, okCallback, errCallback) {
        var doc = new XMLHttpRequest()

        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                var resObj = {}
                if (doc.status == 200) {
                    var a = doc.getAllResponseHeaders();
                    Settings.setCachedTransportInfoSize(doc.getResponseHeader("Content-Length"));
                    Settings.setCachedTransportInfo(doc.responseText);
                    okCallback(doc.responseText);
                } else { // Error
                    errCallback(doc.responseText)
                }
            }
        }

        doc.open("GET", request)
        doc.setRequestHeader("Cookie:", "gts.web.guid=-1")
        doc.send()
    }*/


    function updateTransportInfo(url, okCallback, failCallback) {
        var buses = [];
        var trolleybusses = [];
        makeRequst(url,
                   function(result) {
                        var data = JSON.parse(result)
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
                        okCallback(buses, trolleybusses)
                   },
                   function(result) {
                       failCallback()
                   });
    }


    function callUpdate() {
        header.state = "Updating";
        //dataUpdateWorker.sendMessage({'url' : API.apiEndpoints.transportInfoURL})
        updateTransportInfo(API.apiEndpoints.transportInfoURL, function() {}, function() {});
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

