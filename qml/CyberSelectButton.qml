import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: item1
    width: 500
    height: 130

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.horizontalCenterOffset: -20

    property string displayText: "DEFAULT"
    property bool active: false

    signal cliced()

    BorderImage {
        id: borderImage
        anchors.fill: parent
        source: "qrc:/images/cyber_select_inactive_3.png"
        anchors.rightMargin: 21
        anchors.leftMargin: 22
        anchors.bottomMargin: 22
        anchors.topMargin: 32
    }

    BorderImage {
        id: borderImage1
        visible: false
        anchors.fill: parent
        source: "qrc:/images/cyber_select_hover_3.png"
        anchors.rightMargin: 21
        anchors.topMargin: 32
        anchors.bottomMargin: 22
        anchors.leftMargin: 22
    }

    BorderImage {
        id: borderImage2
        visible: false
        anchors.fill: parent
        source: "qrc:/images/cyber_select_active_3.png"
        anchors.rightMargin: 21
        anchors.topMargin: 32
        anchors.bottomMargin: 22
        anchors.leftMargin: 22
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        anchors.rightMargin: 21
        anchors.topMargin: 32
        anchors.bottomMargin: 22
        anchors.leftMargin: 22

        onClicked: {
            // active = !active
            cliced()
        }
    }

    Text {
        id: text1
        x: 38
        y: 42
        width: 324
        height: 66
        color: "#2a3f6c"
        text: qsTr(displayText)
        font.pixelSize: 45
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        leftPadding: 40
        font.family: "Cyber Alert"
    }

    states: [
        State {
            name: "State1"
            when: mouseArea.containsMouse && !active

            PropertyChanges {
                target: borderImage
                visible: false
            }

            PropertyChanges {
                target: borderImage1
                visible: true
            }

            PropertyChanges {
                target: borderImage2
                visible: false
            }
        },
        State {
            name: "State2"
            when: active
            PropertyChanges {
                target: borderImage
                visible: false
            }

            PropertyChanges {
                target: borderImage1
                visible: false
            }

            PropertyChanges {
                target: borderImage2
                visible: true
            }

            PropertyChanges {
                target: text1
                color: "#7265E3"
            }
        }
    ]
}

