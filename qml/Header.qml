import QtQuick 2.0
import "UI.js" as UI

Rectangle {
    id: header
    height: UI.UI.height / 8
    width: UI.UI.width
    anchors.left: parent.left
    anchors.right: parent.right
    color: "red"

    property alias leftButtonSource: leftButton.source

    Image {
        id: leftButton
        width: height
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        source: "../res/ic_arrow_back_white_48dp.png"

        MouseArea {
            anchors.fill: parent
            onClicked: header.onBackButtonClicked()
        }
    }


    Image {
        id: rightButton
        width: height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        source: "../res/ic_autorenew_white_48dp.png"

        MouseArea {
            anchors.fill: parent
            onClicked: header.onRefreshButtonClicked()
        }
    }
}

