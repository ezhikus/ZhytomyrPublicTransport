import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

import "API.js" as API
import "UI.js" as UI

ApplicationWindow {
    id: mainWindow
    width: UI.UI.width
    height: UI.UI.height
    visible: true

    StackView {
        id: mainStackView

        Component.onCompleted: {
            UI.UI.width = Screen.width
            UI.UI.height = Screen.height

            mainStackView.push(Qt.resolvedUrl("SelectTransportScreen.qml"))
            mainStackView.push(Qt.resolvedUrl("UpdateDataScreen.qml"))
        }
    }
}
