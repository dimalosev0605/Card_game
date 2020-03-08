import QtQuick 2.11
import QtQuick.Controls 2.4
import Bot_model_qml 1.0
import Human_model_qml 1.0
import Referee_model_qml 1.0

Rectangle {
    id: root
    color: main_menu_view_font_rect.canvas_color
    z: 0

    Referee_model {
        id: referee_model
        onChange_curr_item_img: {
            referee_middle_view.currentItem.source = path_to_img
        }
        onWinner_id: {
            switch(id) {
            case 0: ++human_score.score; break;
            case 1: ++left_bot_score.score; break;
            case 2: ++top_bot_score.score; break;
            case 3: ++right_bot_score.score; break;
            case 4: ++draw_text.score; break;
            }
        }
        onStart_new_round: {
            referee_model.shuffle_cards()
            human_model.receive_cards(referee_model.give_cards_for_player(0))
            left_bot_model.receive_cards(referee_model.give_cards_for_player(1))
            top_bot_model.receive_cards(referee_model.give_cards_for_player(2))
            right_bot_model.receive_cards(referee_model.give_cards_for_player(3))
        }
        onPush_opened_cards_view: {
            stack_view.push(opened_cards_view_comp)
        }
        onPop_opened_cards_view: {
            stack_view.pop()
        }
    }
    Human_model {
        id: human_model
        onActivate_bots: {
            referee_model.receive_card(left_bot_model.pop_last_card())
        }
    }
    Bot_model {
        id: left_bot_model
        is_rotate: true
        onActivate_next_bot: {
            referee_model.receive_card(top_bot_model.pop_last_card())
        }
    }
    Bot_model {
        id: top_bot_model
        onActivate_next_bot: {
            referee_model.receive_card(right_bot_model.pop_last_card())
        }
    }
    Bot_model {
        id: right_bot_model
        is_rotate: true
        onActivate_next_bot: {
            human_list_view.enabled = true
        }
    }

    Component {
        id: opened_cards_view_comp
        Opened_cards_view {
            id: opened_cards_view
        }
    }

    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 3
    }
    Text {
        id: human_score
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: back_btn.anchors.margins
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: 100
        height: back_btn.height
        fontSizeMode: Text.Fit
        minimumPointSize: 1
        font.pointSize: 12
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
        property int score: 0
        text: "Ваш счёт: " + score
    }
    Rectangle {
        id: draw_rect
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: back_btn.anchors.margins
        color: back_btn.color
        width: back_btn.width
        height: back_btn.height
        radius: back_btn.radius
        Text {
            id: draw_text
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: parent.height
            fontSizeMode: Text.Fit
            minimumPointSize: 1
            font.pointSize: 12
            elide: Text.ElideRight
            wrapMode: Text.WordWrap

            property int score: 0
            text: "Играть!"
        }
        Binding {
            target: draw_text
            property: "text"
            value: "Ничья: " + draw_text.score
            when: !draw_m_area.is_first_click
        }
        MouseArea {
            id: draw_m_area
            anchors.fill: parent
            property bool is_first_click: true
            onClicked: {
                if(is_first_click) {
                    is_first_click = false
                    draw_text.text = "Ничья: " + draw_text.score

                    left_bot_score.visible = true
                    top_bot_score.visible = true
                    right_bot_score.visible = true
                    human_scroll_bar.visible = true

                    human_model.receive_cards(referee_model.give_cards_for_player(0))
                    left_bot_model.receive_cards(referee_model.give_cards_for_player(1))
                    top_bot_model.receive_cards(referee_model.give_cards_for_player(2))
                    right_bot_model.receive_cards(referee_model.give_cards_for_player(3))
                }
            }
        }
    }

    ListView {
        id: human_list_view
        z: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: human_scroll_bar.top
        anchors.bottomMargin: 1
        height: ((width - spacing * 5) / 6) / 0.7
        ScrollBar.horizontal: human_scroll_bar

        orientation: ListView.Horizontal
        model: human_model
        spacing: 2
        delegate: Card_delegate {
            source: String(model.img_path)
            z: 2
            width: (human_list_view.width - human_list_view.spacing * 5) / 6
            height: human_list_view.height
            opacity: (height - Math.abs(y)) / height
        }
    }
    ScrollBar {
        id: human_scroll_bar
        visible: false
        anchors.bottom: back_btn.top
        anchors.left: human_list_view.left
        active: true
        hoverEnabled: true
        orientation: Qt.Horizontal
        contentItem: Rectangle {
            implicitWidth: human_list_view.width - 10
            implicitHeight: 10
            radius: 5
            color: "#ffffff"
        }
    }

    property int bots_cards_size: 30
    property int scorces_width: 100
    property int scorces_height: 30
    ListView {
        id: top_bot_list_view
        z: 1
        anchors.horizontalCenter: parent.horizontalCenter
        height: bots_cards_size
        width: parent.width < (bots_cards_size * 9 + top_bot_list_view.spacing * 8) ?
                   bots_cards_size : (bots_cards_size * 9 + top_bot_list_view.spacing * 8)
        model: top_bot_model
        orientation: Qt.Horizontal
        spacing: 2

        delegate: Card_delegate {
            source: String(model.img_path)
            z: 2
            img_m_area.visible: false
            height: bots_cards_size
            width: bots_cards_size
        }
    }
    Text {
        id: top_bot_score
        z: 4
        visible: false
        anchors.top: top_bot_list_view.bottom
        anchors.horizontalCenter: top_bot_list_view.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: scorces_width
        height: scorces_height
        fontSizeMode: Text.Fit
        minimumPointSize: 1
        font.pointSize: 12
        elide: Text.ElideRight
        wrapMode: Text.WordWrap

        property int score: 0
//        text: "Top bot: " + score
        text: "Андрей: " + score
    }

    property int left_and_right_bots_view_height: bots_cards_size * 9 + left_bot_list_view.spacing * 8
    ListView {
        id: left_bot_list_view
        z: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: bots_cards_size
        height: (parent.height / 2 + left_and_right_bots_view_height / 2) > human_list_view.y ?
                    bots_cards_size : left_and_right_bots_view_height
        model: left_bot_model
        spacing: 2

        delegate: Card_delegate {
            source: String(model.img_path)
            z: 2
            img_m_area.visible: false
            height: bots_cards_size
            width: bots_cards_size
        }
    }
    Text {
        id: left_bot_score
        z: 4
        visible: false
        anchors.left: left_bot_list_view.left
        anchors.verticalCenter: left_bot_list_view.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: scorces_width
        height: scorces_height
        fontSizeMode: Text.Fit
        minimumPointSize: 1
        font.pointSize: 12
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
        rotation: 90

        property int score: 0
//        text: "Left bot: " + score
        text: "Эдгар: " + score
    }

    ListView {
        id: right_bot_list_view
        z: 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        width: bots_cards_size
        height: left_bot_list_view.height
        model: right_bot_model
        spacing: 2

        delegate: Card_delegate {
            source: String(model.img_path)
            z: 2
            img_m_area.visible: false
            height: bots_cards_size
            width: bots_cards_size
        }
    }
    Text {
        id: right_bot_score
        z: 4
        visible: false
        anchors.right: right_bot_list_view.right
        anchors.verticalCenter: right_bot_list_view.verticalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: scorces_width
        height: scorces_height
        fontSizeMode: Text.Fit
        minimumPointSize: 1
        font.pointSize: 12
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
        rotation: -90

        property int score: 0
//        text: "Right bot: " + score
        text: "Саша: " + score
    }

    property int referee_card_height: 80
    property int referee_card_width: referee_card_height* 0.7
    GridView {
        id: referee_middle_view
        anchors.top: top_bot_score.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        z: 0
        width: referee_card_width * 3
        height: referee_card_height * 3
        cellWidth: width / 3
        cellHeight:  height / 3
        model: referee_model

        delegate: Card_delegate {
            z: 0
            source: String(model.img_path)
            img_m_area.visible: false
            width: referee_middle_view.cellWidth - 2
            height: referee_middle_view.cellHeight - 2
        }
    }
}
