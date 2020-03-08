import QtQuick 2.11

Rectangle {
    id: root
    color: main_menu_view_font_rect.canvas_color

    Text {
        id: this_draw_text
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: 100
        height: 30
        fontSizeMode: Text.Fit
        minimumPointSize: 1
        font.pointSize: 12
        elide: Text.ElideRight
        wrapMode: Text.WordWrap

        property int score: 0
        text: draw_text.text
    }

    GridView {
        id: opened_cards_view
        anchors.top: this_draw_text.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 5

        model: referee_model
        cellWidth: width / 4
        cellHeight: cellWidth / 0.7

        header: Row {
            id: header_row
            width: opened_cards_view.width
            height: 30
            Text {
                width: opened_cards_view.cellWidth
                height: header_row.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                minimumPointSize: 1
                font.pointSize: 12
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                text: human_score.text
            }
            Text {
                width: opened_cards_view.cellWidth
                height: header_row.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                minimumPointSize: 1
                font.pointSize: 12
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                text: left_bot_score.text
            }
            Text {
                width: opened_cards_view.cellWidth
                height: header_row.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                minimumPointSize: 1
                font.pointSize: 12
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                text: top_bot_score.text
            }
            Text {
                width: opened_cards_view.cellWidth
                height: header_row.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                minimumPointSize: 1
                font.pointSize: 12
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                text: right_bot_score.text
            }
        }

        delegate: Card_delegate {
            source: String(model.img_path)
            img_m_area.visible: false
            width: opened_cards_view.cellWidth - 10
            height: opened_cards_view.cellHeight - 10
        }
    }
}
