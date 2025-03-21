import QtQuick
import "modules"

Item {

    property int level: 0

    EllipseItem {
        id: ellipse
        width: parent.width
        height: parent.height
        scale: 1
        strokeStyle: 0
        fillColor: "#110e2f"
        anchors.horizontalCenter: parent.horizontalCenter


        BorderImage {
            id: fan
            source: "qrc:/images/turbine.png"
            width: parent.width
            height: parent.height
            x: 6
            y: 0
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0

        // }

        // ArcItem {
            // id: arc2
            // x: 6
            // y: 0
            // width: 500
            // height: 500
            // dashPattern: [1.1,1,0,0]
            // anchors.horizontalCenterOffset: 0
            // arcWidth: 16
            // strokeColor: "#2e425d"
            // end: 360
            // strokeWidth: 100
            // begin: 0
            // strokeStyle: 2
            // capStyle: 0
            // anchors.horizontalCenter: parent.horizontalCenter
            // fillColor: "#00000000"

            RotationAnimation on rotation {
                from: 0
                to: 360 / 6
                duration: 4000 / 6 - Math.floor(3000 / 6 * level / 100)
                loops: Animation.Infinite
                running: true

                // Behavior on duration {
                //         NumberAnimation {
                //             easing.type: Easing.InOutCubic  // Smooth acceleration/deceleration
                //             duration: 3000  // Transition duration when changing speed
                //         }
                //     }
            }
        }
    }



    EllipseItem {
        id: ellipse1
        width: 225
        height: 225
        fillColor: "#3a3567"
        strokeStyle: 0
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        // ArcItem {
        //     id: arc
        //     width: 225
        //     height: 225
        //     strokeColor: "#70a2ea"
        //     end: 180 + level * 1.8
        //     begin: 180 - level * 1.8
        //     capStyle: 0
        //     strokeStyle: 1
        //     strokeWidth: 16
        //     fillColor: "#00000000"
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     anchors.verticalCenter: parent.verticalCenter
        // }

        Text {
            id: text1
            x: 54
            y: 61
            width: 167
            height: 154
            color: "#70a2ea"
            text: level
            font.pixelSize: 55
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "CyberAlert"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
    }


}
