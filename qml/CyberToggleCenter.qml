import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: item1

    MouseArea {
        id: mouseArea1
        anchors.fill: parent
        hoverEnabled: true

        BorderImage {
            id: borderImageInactive1
            visible: true
            anchors.fill: parent
            source: "qrc:/images/cyber_toggle_center_inactive.png"
        }

        BorderImage {
            id: borderImageHover1
            visible: false
            anchors.fill: parent
            source: "qrc:/images/cyber_toggle_center_hover.png"
        }

        BorderImage {
            id: borderImageActive1
            visible: false
            anchors.fill: parent
            source: "qrc:/images/cyber_toggle_center_active.png"
        }

        Text {
            id: text2
            color: "#70a2ea"
            text: qsTr("AUTO")
            font.pixelSize: 35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 5
            font.family: "Cyber Alert"
        }
    }
    states: [
        State {
            name: "hover"
            when: mouseArea1.containsMouse

            PropertyChanges {
                target: borderImageInactive1
                visible: false
            }

            PropertyChanges {
                target: borderImageHover1
                visible: true
            }
        }
    ]
}
