import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: item1
    MouseArea {
        id: mouseArea2
        anchors.fill: parent
        hoverEnabled: true

        BorderImage {
            id: borderImageInactive2
            visible: true
            anchors.fill: parent
            source: "qrc:/images/cyber_toggle_right_inactive.png"
        }

        BorderImage {
            id: borderImageHover2
            visible: false
            anchors.fill: parent
            source: "qrc:/images/cyber_toggle_right_hover.png"
        }

        BorderImage {
            id: borderImageActive2
            visible: false
            anchors.fill: parent
            source: "qrc:/images/cyber_toggle_right_active.png"
        }

        Text {
            id: text3
            color: "#70a2ea"
            text: qsTr("MAX")
            font.pixelSize: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 5
            font.family: "Vipnagorgialla"
        }
    }
    states: [
        State {
            name: "State1"
            when: mouseArea2.containsMouse

            PropertyChanges {
                target: borderImageInactive2
                visible: false
            }

            PropertyChanges {
                target: borderImageHover2
                visible: true
            }
        }
    ]
}
