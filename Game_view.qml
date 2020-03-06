import QtQuick 2.11

Rectangle {
    id: root
    color: main_menu_view_font_rect.canvas_color
    z: 0

    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 3
    }

}
