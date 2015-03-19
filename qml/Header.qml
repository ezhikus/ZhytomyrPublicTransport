import QtQuick 2.0
import "UI.js" as UI

Rectangle {
    id: header
    height: UI.UI.height / 8
    width: UI.UI.width
    color: "red"

    Component.onCompleted: {
        if (parent !== null) {
            anchors.left = Qt.binding(function() { return parent.left; })
            anchors.right = Qt.binding(function() { return parent.right; })
        }
    }

    property alias leftButtonSource: leftButton.source

    signal leftButtonClicked
    signal rightButtonClicked

    Image {
        id: leftButton
        width: height
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        source: "../res/ic_arrow_back_white_48dp.png"

        MouseArea {
            anchors.fill: parent
            onClicked: header.leftButtonClicked()
        }
    }


    Image {
        id: rightButton
        width: height
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.right: parent.right
        source: "../res/ic_autorenew_white_48dp.png"

        RotationAnimation on rotation {
                id: rotationAnimation
                loops: Animation.Infinite
                from: 0
                to: 360
                duration: 1500
                running: false
            }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                //rotationAnimation.running = true
                header.rightButtonClicked()
            }
        }
    }
}

