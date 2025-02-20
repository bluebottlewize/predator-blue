import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property var stepsize: 0.1
    property var from: 0
    property var to: 1
    property var valueWrapper: 0.5

    signal valueChangedWrapper()

    Slider {
        id: slider
        anchors.fill: parent
        value: valueWrapper / 100
        stepSize: 0.01
        from: 0
        to: 1

        onValueChanged: {
            valueWrapper = Math.round(value * 100)
            valueChangedWrapper()
        }

        background: Item {
                    id: clipArea
                    // Bind the width to the slider's width times its value (value from 0 to 1)
                    x: 50
                    width: (slider.width - 100) * slider.value
                    height: slider.height
                    clip: true

                    BorderImage {
                        id: borderImage1
                        source: "../images/cyber_slider_body.png"
                        // Set border values as needed
                        width: parent.parent.width - 100
                        height: parent.parent.height

                        border.left: 5
                        border.top: 5
                        border.right: 5
                        border.bottom: 5
                    }
        }

        handle: BorderImage {
            id: habdle
            source: "../images/cyber_slider_head.png"
            x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
            y: slider.topPadding + slider.availableHeight / 2 - height / 2

            Text {
                id: text1
                color: "#70a2ea"
                text: qsTr( "" + Math.round(slider.value * 100))
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 25
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 3
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: "Cyber Alert"
            }
        }
    }
}
