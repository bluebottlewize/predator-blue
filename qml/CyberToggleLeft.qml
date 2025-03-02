import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: item1

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        BorderImage {
            id: borderImageInactive
            visible: true
            anchors.fill: parent
            source: "qrc:/images/cyber_toggle_left_inactive.png"
        }

        BorderImage {
            id: borderImageHover
            visible: false
            anchors.fill: parent
            source: "qrc:/images/cyber_toggle_left_hover.png"
        }

        BorderImage {
            id: borderImageActive
            visible: false
            anchors.fill: parent
            source: "qrc:/images/cyber_toggle_left_active.png"
        }

        Text {
            id: text1
            color: "#70a2ea"
            text: qsTr("CUSTOM")
            font.pixelSize: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 5
            font.family: "Vipnagorgialla"
        }
    }
    states: [
        State {
            name: "hover"
            when: mouseArea.containsMouse && !mouseArea.pressed

            PropertyChanges {
                target: borderImageInactive
                visible: false
            }

            PropertyChanges {
                target: borderImageHover
                visible: true
            }

            PropertyChanges {
                target: borderImageActive
                visible: false
            }
        },
        State {
            name: "active"
            when: mouseArea.pressed

            PropertyChanges {
                target: borderImageInactive
                visible: false
            }

            PropertyChanges {
                target: borderImageHover
                visible: false
            }

            PropertyChanges {
                target: borderImageActive
                visible: true
            }
        }
    ]
}
