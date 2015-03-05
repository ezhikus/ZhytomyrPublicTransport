import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import "API.js" as API

ApplicationWindow {
    id: mainWindow
    width: 480
    height: 800
    visible: true

    StackView {
        id: mainStackView

        Component.onCompleted: {
            mainStackView.push(Qt.resolvedUrl("SelectTransportScreen.qml"))
            mainStackView.push(Qt.resolvedUrl("UpdateDataScreen.qml"))
        }
    }
}
