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

        background:

            BorderImage {
                id: borderImage1
                source: "qrc:/images/cyber_slider_body_outline.png"
                // Set border values as needed
                width: slider.width - 100
                height: slider.height
                anchors.horizontalCenter: parent.horizontalCenter

                border.left: 5
                border.top: 5
                border.right: 5
                border.bottom: 5

            Item {
                    id: clipArea
                    // Bind the width to the slider's width times its value (value from 0 to 1)
                    width: (slider.width - 100) * slider.value
                    height: slider.height
                    clip: true

                    BorderImage {
                        id: borderImage2
                        source: "qrc:/images/cyber_slider_body_fill.png"
                        // Set border values as needed
                        width: slider.parent.width - 100
                        height: slider.parent.height

                        border.left: 5
                        border.top: 5
                        border.right: 5
                        border.bottom: 5
                    }
            }
        }


        handle: BorderImage {
            id: handle
            source: "qrc:/images/cyber_slider_head.png"
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
