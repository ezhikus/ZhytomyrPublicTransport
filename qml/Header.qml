import QtQuick 2.0

Rectangle {
    id: header
    height: parent.height * 0.12
    width: parent.width
    color: "red"

    property url closeButtonPath: '../res/ic_close_white_48dp.png'
    property url backButtonPath: '../res/ic_arrow_back_white_48dp.png'
    property url updateButtonPath: '../res/ic_autorenew_white_48dp.png'

    property alias leftButtonSource: leftButton.source

    signal leftButtonClicked
    signal rightButtonClicked

    Component.onCompleted: {
        if (parent !== null) {
            anchors.left = Qt.binding(function() { return parent.left; })
            anchors.right = Qt.binding(function() { return parent.right; })
            height = Qt.binding(function() { return mainWindow.height * 0.1; })
        }
    }

    Image {
        id: leftButton
        width: height
        anchors { bottom: parent.bottom; top: parent.top; left: parent.left }
        source: closeButtonPath
        asynchronous: true

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
        anchors { bottom: parent.bottom; top: parent.top; right: parent.right }

        source: updateButtonPath
        asynchronous: true

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

