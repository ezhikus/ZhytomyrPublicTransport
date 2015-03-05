import QtQuick 2.0
import QtQuick.Controls 1.2


Rectangle {
    id: startScreenRoot
    width: 480
    height: 800

    GroupBox {
        id: dataLoadingState
        anchors.fill: parent

        Text {
            id: dataLoadingLabel
            x: 53
            y: 282
            text: qsTr("Дані завантажуються")
            anchors.horizontalCenterOffset: 2
            font.pointSize: 26
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        ProgressBar {
            id: dataLoadProgressBar
            x: 53
            y: 436
            width: 342
            height: 23
            indeterminate: true
            anchors.horizontalCenterOffset: 2
            activeFocusOnTab: false
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    GroupBox {
        id: connectionErrorState
        visible: false
        anchors.fill: parent

        Button {
            id: retryButton
            x: 99
            y: 389
            width: 241
            height: 54
            visible: true
            text: "Повторити"
        }

        Text {
            id: errorDataLoadLabel
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

