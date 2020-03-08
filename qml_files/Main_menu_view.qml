import QtQuick 2.11

Rectangle {
    id: main_menu_view_font_rect
    color: "#000000"
    z: 0
    property alias canvas_color: main_rect.color

    Rectangle {
        id: main_rect
        z: 1
        anchors.fill: parent
        color: "#04541e"
        border.color: "#7e4006"
        border.width: 7
        radius: 20

        Component {
            id: game_view_comp
            Game_view {
                id: game_view
            }
        }

        Column {
            id: column_with_btns
            anchors.centerIn: parent
            z: 2

            property int btns_width: parent.width / 3
            property int btns_height: parent.height / 6

            Main_menu_view_btn {
                id: rules_btn
                width: parent.btns_width
                height: parent.btns_height
                color: main_rect.color
                btn_text.text: "Правила"
//                btn_m_area.onClicked: stack_view.push()
            }
            Main_menu_view_btn {
                id: play_btn
                width: parent.btns_width
                height: parent.btns_height
                color: main_rect.color
                btn_text.text: "Новая игра"
                btn_m_area.onClicked: stack_view.push(game_view_comp)
            }
            Main_menu_view_btn {
                id: exit_btn
                width: parent.btns_width
                height: parent.btns_height
                color: main_rect.color
                btn_text.text: "Выход"
                btn_m_area.onClicked: Qt.quit()
            }
        }

        property int rot_alpha: 5
        property int card_height: column_with_btns.height / 2
        property int card_width: card_height * 0.7
        Image {
            id: right_top_card
            z: 2
            source: "qrc:/cards/hearts/ace.svg"
            height: parent.card_height
            width: parent.card_width
            anchors.top: column_with_btns.top
            anchors.left: column_with_btns.right
            rotation: -parent.rot_alpha
        }
        Image {
            id: right_bot_card
            z: 2
            source: "qrc:/cards/spades/queen.svg"
            height: parent.card_height
            width: parent.card_width
            anchors.top: right_top_card.bottom
            anchors.left: right_top_card.left
            rotation: parent.rot_alpha
        }
        Image {
            id: left_top_card
            z: 2
            source: "qrc:/cards/spades/7.svg"
            height: parent.card_height
            width: parent.card_width
            anchors.top: column_with_btns.top
            anchors.right: column_with_btns.left
            rotation: parent.rot_alpha
        }
        Image {
            id: left_bot_card
            z: 2
            source: "qrc:/cards/hearts/7.svg"
            height: parent.card_height
            width: parent.card_width
            anchors.top: left_top_card.bottom
            anchors.left: left_top_card.left
            rotation: -parent.rot_alpha
        }
    }
}
