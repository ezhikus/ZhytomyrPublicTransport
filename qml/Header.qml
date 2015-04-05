import QtQuick 2.0
import "UI.js" as UI

Rectangle {
    id: header
    height: UI.UI.height * 0.12
    width: UI.UI.width
    color: "red"

    property string closeButtonPath: '../res/ic_close_white_48dp.png'
    property string backButtonPath: '../res/ic_arrow_back_white_48dp.png'
    property string updateButtonPath: '../res/ic_autorenew_white_48dp.png'

    property alias leftButtonSource: leftButton.source

    signal leftButtonClicked
    signal rightButtonClicked

    Component.onCompleted: {
        if (parent !== null) {
            anchors.left = Qt.binding(function() { return parent.left; })
            anchors.right = Qt.binding(function() { return parent.right; })
            height = Qt.binding(function() { return mainWindow.height > mainWindow.width ? mainWindow.height * 0.1 : mainWindow.height * 0.18; })
        }
    }

    Image {
        id: leftButton
        width: height
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        source: closeButtonPath

        MouseArea {
            anchors.fill: parent
            onClicked: {
                header.leftButtonClicked()
            }
        }
    }


    Image {
        id: rightButton
        width: height
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.right: parent.right
        source: updateButtonPath

        RotationAnimation on rotation {
                id: rotationAnimation
                from: 0
                to: 360
                duration: 1500
                running: false
            }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                header.rightButtonClicked()
            }
        }
    }

    states: [
        State {
            name: "Normal"

            PropertyChanges {
                target: rotationAnimation
                running: true
                loops: 1
            }
        },
        State {
            name: "Updating"

            PropertyChanges {
                target: rotationAnimation
                loops: Animation.Infinite
                running: true
            }
        }
    ]
}

