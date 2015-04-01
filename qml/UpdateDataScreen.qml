import QtQuick 2.0
import QtQuick.Controls 1.2

import "UI.js" as UI

Rectangle {
    id: updateDataScreen
    width: UI.UI.width
    height: UI.UI.height

    function callUpdate() {
        mainStackView.get(mainStackView.depth - 2).callUpdate()
    }

    Rectangle {
        id: dataLoadingState
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top

        Text {
            id: dataLoadingLabel
            text: qsTr("Дані завантажуються")
            anchors.verticalCenterOffset: 0 - height * 2
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: updateDataScreen.width * 0.08
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
        }

        ProgressBar {
            width: dataLoadingLabel.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            indeterminate: true
            activeFocusOnTab: false
        }
    }

    Rectangle {
        id: connectionErrorState
        visible: false
        anchors.fill: parent

        Text {
            text: qsTr("Помилка завантаження даних\n Немає зв'язку з Інтернетом?")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: updateDataScreen.width * 0.05
            font.bold: true
            wrapMode: Text.WordWrap
            horizontalAlignment : Text.AlignHCenter
            anchors.verticalCenterOffset: 0 - parent.height * 0.2
        }

        Button {
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 0 + parent.height * 0.1
            text: "Повторити"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    updateDataScreen.callUpdate()
                }
            }
        }
    }

    states: [
        State {
            name: "Updating"

            PropertyChanges {
                target: dataLoadingState
                visible: true
            }

            PropertyChanges {
                target: connectionErrorState
                visible: false
            }
        },
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

