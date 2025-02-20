import QtQuick
import QtQuick.Controls
import PredatorBlue
import QtQuick.Studio.Components 1.0
import QtQuick3D.Particles3D 6.2
import org.bluebottle.SysfsWriter

Window {
    visible: true

    SysfsWriter {
        id: writer
    }

    Component.onCompleted: {
        console.log(writer.getCpuFanSpeed());
        console.log(writer.getGpuFanSpeed());
        slider.value = Math.round(writer.getCpuFanSpeed() * 2.7);
        slider1.value = Math.round(writer.getGpuFanSpeed() * 2.7);

        console.log(slider1.value);

        arc.end = slider.value - 135
        text1.text = Math.round(slider.value / 270 * 100)

        arc1.end = slider1.value - 135
        text2.text = Math.round(slider1.value / 270 * 100)
    }

    Rectangle {
        width: Constants.width
        height: Constants.height
        color: "#0d143d"

        Column {
            id: column
            x: 8
            y: 8
            width: 450
            height: 1064
        }

        Column {
            id: column1
            x: 464
            y: 8
            width: 615
            height: 1064
            padding: 50
            spacing: 200
            clip: false

            EllipseItem {
                id: ellipse
                width: 500
                height: 500
                scale: 1
                strokeStyle: 0
                fillColor: "#110e2f"
                anchors.horizontalCenter: parent.horizontalCenter

                ArcItem {
                    id: arc
                    x: 15
                    y: 16
                    width: 470
                    height: 470
                    strokeColor: "#70a2ea"
                    end: 135
                    begin: -135
                    capStyle: 0
                    strokeStyle: 1
                    strokeWidth: 60
                    fillColor: "#00000000"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                EllipseItem {
                    id: ellipse1
                    x: 113
                    y: 113
                    width: 275
                    height: 275
                    fillColor: "#3a3567"
                    strokeStyle: 0
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: text1
                        x: 54
                        y: 61
                        width: 167
                        height: 154
                        color: "#70a2ea"
                        text: qsTr("100")
                        font.pixelSize: 100
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Verdana"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            Slider {
                id: slider
                width: 500
                height: 50
                stepSize: 1
                value: 0.5

                Connections {
                    target: slider
                    onValueChanged: {
                        arc.end = slider.value - 135
                        text1.text = Math.floor(slider.value / 270 * 100)
                        writer.setFanSpeed(parseInt(text1.text), parseInt(text2.text))
                    }
                }
                to: 270
                from: 0
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Column {
            id: column2
            x: 1112
            y: 8
            width: 615
            height: 1064
            EllipseItem {
                id: ellipse3
                width: 500
                height: 500
                scale: 1
                ArcItem {
                    id: arc1
                    x: 15
                    y: 16
                    width: 470
                    height: 470
                    strokeColor: "#70a2ea"
                    anchors.horizontalCenter: parent.horizontalCenter
                    strokeStyle: 1
                    fillColor: "#00000000"
                    end: 135
                    strokeWidth: 60
                    begin: -135
                    capStyle: 0
                }

                EllipseItem {
                    id: ellipse2
                    x: 113
                    y: 113
                    width: 275
                    height: 275
                    Text {
                        id: text2
                        x: 54
                        y: 61
                        width: 167
                        height: 154
                        color: "#70a2ea"
                        text: qsTr("100")
                        font.pixelSize: 100
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: "Verdana"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillColor: "#3a3567"
                    strokeStyle: 0
                }
                anchors.horizontalCenter: parent.horizontalCenter
                strokeStyle: 0
                fillColor: "#110e2f"
            }

            Slider {
                id: slider1
                width: 500
                height: 50
                Connections {
                    target: slider1
                    onValueChanged: {
                        arc1.end = slider1.value - 135
                        text2.text = Math.floor(slider1.value / 270 * 100)
                        writer.setFanSpeed(parseInt(text1.text), parseInt(text2.text))
                    }
                }
                value: 0.5
                anchors.horizontalCenter: parent.horizontalCenter
                stepSize: 1
                to: 270
                from: 0
            }
            spacing: 200
            clip: false
            padding: 50
        }
    }
}
