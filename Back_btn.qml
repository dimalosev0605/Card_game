import QtQuick 2.11

Rectangle {
    id: back_btn
    width: 55
    height: 40
    border.width: 1
    border.color: "#000000"
    radius: 5

    Text {
        text: "Назад"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        height: parent.height
        fontSizeMode: Text.Fit
        minimumPointSize: 1
        font.pointSize: 12
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }
    MouseArea {
        anchors.fill: parent
        onClicked: stack_view.pop()
    }
}
