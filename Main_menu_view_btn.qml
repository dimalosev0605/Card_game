import QtQuick 2.11

Rectangle {
    id: btn

    property alias btn_m_area: btn_m_area
    property alias btn_text: btn_text

    MouseArea {
        id: btn_m_area
        anchors.fill: parent
    }
    Text {
        id: btn_text
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
}
