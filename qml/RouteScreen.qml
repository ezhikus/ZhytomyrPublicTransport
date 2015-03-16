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

    Component.onCompleted: {
        if (initialized === false) {
            API.updateRouteInfo(routeId);
            initialized = true;
        }
    }

    Header {
        id: routeScreenHeader
        function onBackButtonClicked() {
            mainStackView.pop()
        }

        function onRefreshButtonClicked() {
            API.updateRouteInfo(routeId)
        }
    }

    Text {
        id: routeNumberLabel
        text: routeName
        anchors.top: routeScreenHeader.bottom
        anchors.topMargin: 0
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 20
    }

    ListView {
        id: view
        x: 0
        y: 104
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: routeNumberLabel.bottom
        anchors.topMargin: 0
        model: ListModel {
            id: routeInfo
        }

        delegate:
            Button {
            text : name
            onClicked: {
                var busStopScreen = Qt.resolvedUrl("BusStopScreen.qml")
                mainStackView.push({
                    item: busStopScreen,
                    properties:{
                        busStopId: busStopId,
                        busStopName: name
                    }
                })
            }
        }
    }
}
