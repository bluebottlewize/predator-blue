import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: container
    width: 390
    height: 542 * container.width / 390

    property string mode: ""
    property string description: ""
    property string source: ""

    BorderImage {
        id: borderImage
        anchors.fill: parent
        source: container.source

        Text {
            id: text1
            y: 32 * container.width / 390
            color: "#7265e3"
            text: mode
            anchors.left: parent.left
            anchors.right: parent.right
            font.pixelSize: 50  * container.width / 390
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Cyber Alert"
            anchors.leftMargin: 20 * container.width / 390
            anchors.rightMargin: 20 * container.width / 390
        }

        Text {
            id: text2
            anchors.left: text1.left
            anchors.right: text1.right
            anchors.top: text1.bottom
            anchors.topMargin: 36 * container.width / 390
            height: 98 * container.width / 390
            color: "#7265e3"
            text: description
            font.pixelSize: 30 * container.width / 390
            verticalAlignment: Text.AlignTop
            wrapMode: Text.WordWrap
            font.family: "Vipnagorgialla"
        }
    }
}
