import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    width: 480
    height: 800

    Column {
        id: column1
        anchors.fill: parent

        Rectangle {
            id: header
            height: parent.height / 10
            width: parent.width
            color: "red"

            Text {
                id: text1
                text: qsTr("Обновить")
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 20
                color: "white"
            }
        }

        Text {
            id: busesLabel
            text: qsTr("Маршрутки")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 25
        }

        Rectangle {
            id: buses
            height: parent.height / 10 * 4
            width: parent.width

            Flow {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 10

                Repeater {
                    model: ListModel {
                        ListElement { name: "Alice" }
                        ListElement { name: "Bob" }
                        ListElement { name: "Jane" }
                        ListElement { name: "Harry" }
                        ListElement { name: "Wendy" }
                    }
                    Button { text: name }
                }
            }
        }

        Text {
            id: trolleyBusesLabel
            text: qsTr("Троллейбуси")
            font.pixelSize: 25
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: trolleyBuses
            height: parent.height / 10 * 4
            width: parent.width

            Flow {
                anchors.fill: parent
                anchors.margins: 4
                spacing: 10

                Repeater {
                    model: ListModel {
                        ListElement { name: "Alice" }
                        ListElement { name: "Bob" }
                        ListElement { name: "Jane" }
                        ListElement { name: "Harry" }
                        ListElement { name: "Wendy" }
                    }
                    Button { text: name }
                }
            }
        }
    }
}

