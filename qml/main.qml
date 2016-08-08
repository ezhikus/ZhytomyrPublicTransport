import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

import "API.js" as API

ApplicationWindow {
    id: mainWindow
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
        anchors.fill: parent

        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                if (mainStackView.depth === 1)
                    Qt.quit();
                else
                    mainStackView.pop();
                event.accepted = true;
            }
        }
    }

    Component.onCompleted: {
        if (Qt.platform.os === "android") {
            width = Screen.width;
            height = Screen.height;
        } else
        {
            width = 480;
            height = 854;
        }

        mainStackView.push(Qt.resolvedUrl("SelectTransportScreen.qml"))
        mainStackView.push(Qt.resolvedUrl("UpdateDataScreen.qml"))
    }
}
