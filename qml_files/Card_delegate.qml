import QtQuick 2.11

Image {
    id: img

    property alias img_m_area: img_m_area

    MouseArea {
        id: img_m_area
        anchors.fill: parent

        drag.target: img
        drag.axis: Drag.XAndYAxis
        drag.minimumY: -5000
        drag.maximumY: 5000
        drag.minimumX: -5000
        drag.maximumX: 5000

        onReleased: {
            img.scale = 1
            img.z = 2
            if(-img.y >= img.height) {
                referee_model.receive_card(human_model.get_card(index))
                human_model.remove_card(index)
                ++referee_middle_view.currentIndex
                human_list_view.enabled = false
            }
            else {
                img.x = img.width * index + human_list_view.spacing * index
                img.y = 0
            }
        }
        onPressAndHold: {
            img.scale = 1.5
            img.z = 3
        }
        onContainsPressChanged: {
            img.scale = 1
            img.z = 2
        }
    }
}
