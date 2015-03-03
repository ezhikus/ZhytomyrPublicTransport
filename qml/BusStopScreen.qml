import QtQuick 2.0

Rectangle {
    id: rectangle2
    width: 480
    height: 800

    Rectangle {
        id: header
        height: parent.height / 10
        width: parent.width
        color: "red"

        Text {
            id: text1
            text: qsTr("Оновити")
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 20
            color: "white"
        }
    }

    Rectangle {
        id: rectangle1
        color: "#ffffff"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: header.bottom
        anchors.topMargin: 0

        Text {
            id: text2
            x: 64
            y: 196
            text: qsTr("До найближчої маршрутки: ")
            font.pixelSize: 12
        }

        Text {
            id: text3
            x: 64
            y: 228
            text: qsTr("До наступної маршрутки:")
            font.pixelSize: 12
        }

        Text {
            id: text4
            x: 235
            y: 196
            text: qsTr("2 хв 55 сек")
            font.pixelSize: 12
        }

        Text {
            id: text5
            x: 235
            y: 228
            text: qsTr("5 хв 40 сек")
            font.pixelSize: 12
        }
    }

}

