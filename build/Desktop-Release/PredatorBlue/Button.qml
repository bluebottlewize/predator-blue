import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: item1
    width: 280
    height: 150

    property string displayText: "DEFAULT"

    FontLoader {
        source: "qrc:/fonts/CyberAlert-xRv8j.otf"
    }

    BorderImage {
        id: borderImage
        anchors.fill: parent
        source: "qrc:/images/cyberbutton.png"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    BorderImage {
        id: borderImage1
        visible: false
        anchors.fill: parent
        source: "qrc:/images/cyberbutton_active.png"
    }
    Text {
        id: text1
        color: "#14dcec"
        text: qsTr(displayText)
        anchors.fill: parent
        font.pixelSize: 50
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        fontSizeMode: Text.Fit
        renderType: Text.QtRendering
        font.bold: false
        font.styleName: "Regular"
        font.family: "Cyber Alert"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    states: [
        State {
            name: "active state"
            when: mouseArea.containsMouse

            PropertyChanges {
                target: borderImage1
                visible: true
            }
        }
    ]
}
