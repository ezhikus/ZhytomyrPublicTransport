import QtQuick 2.0

Rectangle {
    id: header
    height: parent.height / 10
    width: parent.width
    color: "red"

    Text {
        text: qsTr("Назад")
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 20
        color: "white"
        MouseArea {
            anchors.fill: parent
            onClicked: header.onBackButtonClicked()
        }
    }

    Text {
        text: qsTr("Оновити")
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 20
        color: "white"
        MouseArea {
            anchors.fill: parent
            onClicked: header.onRefreshButtonClicked()
        }
    }
}

