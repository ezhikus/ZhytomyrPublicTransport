import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1

import "API.js" as API
import "UI.js" as UI

Rectangle {
    id: selectTransportScreen
    width: UI.UI.width
    height: UI.UI.height
    property bool isInitialized : false

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
                font.pixelSize: header.height / 2.5
            }

            Rectangle {
                height: selectTransportScreen.height > selectTransportScreen.width ? 0.35 * selectTransportScreen.height : 0.7 * selectTransportScreen.height
                width: selectTransportScreen.height > selectTransportScreen.width ? selectTransportScreen.width : 0.45 * selectTransportScreen.width

                Flow {
                    anchors.fill: parent
                    anchors.margins: 15
                    anchors.topMargin: 0
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

    Rectangle {
        anchors.fill: parent

        Component.onCompleted: {
            if (isInitialized == false) {
                API.updateTransportInfo();
                isInitialized = true;
            }
        }

        Header {
            id: header
            leftButtonSource: '../res/ic_close_white_48dp.png'
            onLeftButtonClicked:  Qt.quit()
            onRightButtonClicked: API.updateTransportInfo()
        }

        Rectangle {
            anchors.top: header.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            GridLayout {
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: 20
                rowSpacing: 10
                columnSpacing: 20
                flow:  selectTransportScreen.height < selectTransportScreen.width ? GridLayout.LeftToRight : GridLayout.TopToBottom

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
    }
}

