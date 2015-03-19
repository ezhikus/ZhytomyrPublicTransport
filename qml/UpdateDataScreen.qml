import QtQuick 2.0
import QtQuick.Controls 1.2

import "UI.js" as UI

Rectangle {
    id: startScreenRoot
    width: UI.UI.width
    height: UI.UI.height

    Rectangle {
        id: dataLoadingState
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top

        Text {
            id: dataLoadingLabel
            text: qsTr("Дані завантажуються")
            anchors.verticalCenterOffset: 0 - height * 3
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: startScreenRoot.width * 0.07
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        ProgressBar {
            width: dataLoadingLabel.width
            anchors.verticalCenter: parent.verticalCenter
            indeterminate: true
            activeFocusOnTab: false
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    GroupBox {
        id: connectionErrorState
        visible: false
        anchors.fill: parent

        Button {
            x: 99
            y: 389
            width: 241
            height: 54
            visible: true
            text: "Повторити"
        }

        Text {
            x: 53
            y: 282
            text: qsTr("Помилка завантаження даних")
            anchors.horizontalCenterOffset: 2
            font.pointSize: 24
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    states: [
        State {
            name: "ConnectionError"

            PropertyChanges {
                target: dataLoadingState
                visible: false
            }

            PropertyChanges {
                target: connectionErrorState
                visible: true
            }
        }
    ]
}

