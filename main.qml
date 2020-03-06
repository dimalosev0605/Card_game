import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 350
    height: 600
    StackView {
        id: stack_view
        anchors.fill: parent
        initialItem: Main_menu_view {}
    }
}
