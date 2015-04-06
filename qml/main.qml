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

    toolBar: Header {
        id: header
        onLeftButtonClicked: {
            if (mainStackView.depth === 1)
                Qt.quit();
            else
                mainStackView.pop();
        }

        leftButtonSource: {
            if (parent === null)
                return closeButtonPath;

            if (typeof mainStackView === undefined || mainStackView.depth === 1)
                return closeButtonPath;

            return backButtonPath;
        }

        onRightButtonClicked: {
            mainStackView.currentItem.callUpdate()
        }
    }

    StackView {
        id: mainStackView
        focus: true

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                if (mainStackView.depth === 1)
                    Qt.quit();
                else
                    mainStackView.pop();
                event.accepted = true;
            }
        }

        Component.onCompleted: {
            UI.UI.width = Screen.width
            UI.UI.height = Screen.height

            mainStackView.push(Qt.resolvedUrl("SelectTransportScreen.qml"))
            mainStackView.push(Qt.resolvedUrl("UpdateDataScreen.qml"))
        }
    }
}
