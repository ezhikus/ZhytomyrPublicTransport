import QtQuick 2.0
import QtQuick.Controls 1.2

import "API.js" as API
import "UI.js" as UI

Rectangle {
    id: selectTransportScreen
    width: UI.UI.width
    height: UI.UI.height
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
            leftButtonSource: '../res/ic_close_white_48dp.png'
            onLeftButtonClicked:  Qt.quit()
            onRightButtonClicked: API.updateTransportInfo()
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

                Text {
                    id: groupLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: selectTransportScreen.height / 20
                }

                Rectangle {
                    height: selectTransportScreen.height / 10 * 4
                    width: selectTransportScreen.width

                    Flow {
                        anchors.fill: parent
                        anchors.margins: 4
                        spacing: 5

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
            }
        }
    }
}

