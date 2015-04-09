import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.3

import "API.js" as API
import "UI.js" as UI

Rectangle {
    id: routeScreen
    width: UI.UI.width
    height: UI.UI.height

    property int routeId: -1
    property string routeShortName: ""
    property string routeName: ""

    Component.onCompleted: {
        routeScreen.callUpdate();
    }

    function callUpdate() {
        header.state = "Updating";
        API.updateRouteInfo(routeId,
            function() {
                header.state = "Normal";
            },
            function() {
                /*TODO: show FAIL display*/
            });
    }

    Text {
        id: routeNumberLabel
        text: routeName
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: parent.width * 0.04
    }

    ListView {
        id: view
        clip: true
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: routeNumberLabel.bottom
        anchors.topMargin: parent.height * 0.025
        model: ListModel {
            id: routeInfoModel
        }

        delegate:
            Button {
            text : ' ' + (index + 1) + '. ' + name
            anchors.left: parent.left
            anchors.right: parent.right
            height: header.height
            style: ButtonStyle {
                    label: Text {
                        font.pixelSize: routeScreen.width * 0.05
                        text: control.text
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                    }
                }

            onClicked: {
                var busStopScreen = Qt.resolvedUrl("BusStopScreen.qml")
                mainStackView.push({
                    item: busStopScreen,
                    properties:{
                        routeShortName: routeScreen.routeShortName,
                        busStopParamString: busStopParamString,
                        busStopName: name
                    }
                })
            }
        }
    }
}
