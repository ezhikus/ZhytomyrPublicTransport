import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

ApplicationWindow {
    id: mainWindow
    width: 480
    height: 800
    visible: true

    StackView {
        id: mainStackView
        initialItem: SelectTransportScreen {
            anchors.fill: parent
        }
    }
}
