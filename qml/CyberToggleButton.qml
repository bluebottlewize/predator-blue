import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 6.0

Item {
    id: item1
    width: 581
    height: 81

    property bool active: false
    signal clickedWrapper()

    BorderImage {
        id: rightActive
        visible: active
        anchors.fill: parent
        source: "qrc:/images/cyber_toggle_button_right_active.png"
    }

    BorderImage {
        id: leftActive
        visible: !active
        anchors.fill: parent
        source: "qrc:/images/cyber_toggle_button_left_active.png"
    }

    RowLayout {
        id: rowLayout
        x: 24
        anchors.fill: parent
        spacing: 0

        MouseArea {
            id: leftButton
            width: 100
            height: 100
            Layout.fillHeight: true
            Layout.fillWidth: true

            onClicked: {
                active = false
                clickedWrapper()
            }

            Text {
                id: text1
                color: "#1a0136"
                text: qsTr("OFF")
                anchors.fill: parent
                font.family: "Vipnagorgialla"
                font.pixelSize: 24 * item1.width / 581
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        MouseArea {
            id: rightButton
            width: 100
            height: 100
            Layout.fillHeight: true
            Layout.fillWidth: true

            onClicked: {
                active = true
                clickedWrapper()
            }

            Text {
                id: text2
                color: "#70a2ea"
                text: qsTr("ON")
                anchors.fill: parent
                font.family: "Vipnagorgialla"
                font.pixelSize: 24 * item1.width / 581
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    states: [
        State {
            name: "State1"
            when: active

            PropertyChanges {
                target: text1
                color: "#70a2ea"
            }

            PropertyChanges {
                target: leftActive
            }

            PropertyChanges {
                target: rightActive
            }

            PropertyChanges {
                target: text2
                color: "#1a0136"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}D{i:1}D{i:2}D{i:5}D{i:4}D{i:7}D{i:6}D{i:3}
}
##^##*/
