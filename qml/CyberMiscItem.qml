import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: item1
    width: 369
    height: 261

    property string heading: ""
    property string description: ""
    property bool active: false
    signal stateChangedWrapper()

    BorderImage {
        id: borderImage
        anchors.fill: parent
        source: "qrc:/images/cyber_module_box.png"

        Text {
            id: text1
            height: 44
            color: "#7265E3"
            text: heading
            anchors.left: cyberToggleButton.left
            anchors.right: cyberToggleButton.right
            anchors.top: parent.top
            font.pixelSize: 24 * parent.height / 261
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.family: "Cyber Alert"
            anchors.topMargin: 20 * parent.height / 261
        }

        CyberToggleButton {
            id: cyberToggleButton
            width: parent.width - 40 * parent.height / 261
            height: 42 * parent.height / 261
            anchors.horizontalCenterOffset: - 5 * parent.height / 261
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text1.bottom
            anchors.topMargin: 20 * parent.height / 261
            active: item1.active

            onClickedWrapper: {
                item1.active = cyberToggleButton.active
                stateChangedWrapper()
            }
        }

        Text {
            id: text2
            anchors.top: cyberToggleButton.bottom
            anchors.left: cyberToggleButton.left
            anchors.right: cyberToggleButton.right
            anchors.topMargin: 20 * parent.height / 261

            height: 80 * parent.height / 261
            color: "#7265E3"
            text: description
            font.pixelSize: 16 * parent.height / 261
            wrapMode: Text.WordWrap
            font.family: "Vipnagorgialla"
        }
    }
}
