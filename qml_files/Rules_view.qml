import QtQuick 2.11
import Rules_loader_qml 1.0

Rectangle {
    id: root

    color: "#000000"

    Rules_loader {
        id: rules_loader
    }

    Text {
        id: rules_text
        anchors.fill: parent
        color: "#ffffff"
        text: rules_loader.load_rules()
        font.family: "Arial"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        height: parent.height - back_btn.height
        fontSizeMode: Text.Fit
        minimumPointSize: 1
        font.pointSize: 12
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }

    Back_btn {
        id: back_btn
        color: "#ffffff"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 5
        anchors.bottomMargin: 5
    }
}
