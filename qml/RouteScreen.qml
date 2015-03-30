import QtQuick 2.0
import QtQuick.Controls 1.2

import "API.js" as API
import "UI.js" as UI

Rectangle {
    id: routeScreen
    width: UI.UI.width
    height: UI.UI.height

    property int routeId: -1
    property string routeShortName: ""
    property string routeName: ""

    Stack.onStatusChanged : {
        if (Stack.status == Stack.Active) {
            routeScreen.callUpdate();
        }
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


    Connections {
         target: header
         onRightButtonClicked: {
             if (mainStackView.currentItem === routeScreen)
                routeScreen.callUpdate();
         }
    }

    Text {
        id: routeNumberLabel
        text: routeName
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: parent.width / 25
    }

    ListView {
        id: view
        anchors.topMargin: routeScreen.height / 10
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: routeNumberLabel.bottom
        model: ListModel {
            id: routeInfoModel
        }

        delegate:
            Button {
            text : name
            anchors.left: parent.left
            anchors.right: parent.right
            height: header.height
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
