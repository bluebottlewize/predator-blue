import QtQuick
import "BarsEffect/export"
import "BendEffect/export"
import "GlowEffect/export"

Item {
    id: rootItem

    property real barHeight: 0.4
    property real value: 0
    property color highlightColor: "#ffff00"
    property color barsColor: "#ffffff"
    property int barsAmount: 20
    property real startAngle: 0
    property real spanAngle: Math.PI * 2
    property real glowBloom: 1.0
    property real glowBlur: 0.5
    property real barsSmoothness: 1.0
    property real barsDistribution: 0.5

    // Item for bars with margins so that it contains space also for the glow
    Item {
        id: barsEffectItem
        readonly property real glowMargin: parent.height * 0.2
        width: parent.height * 2.5
        height: barHeight * 0.2 * parent.height + glowMargin * 2
        visible: false
        layer.enabled: true
        BarsEffect {
            anchors.fill: parent
            anchors.margins: barsEffectItem.glowMargin
            barsBarWidth: width / (rootItem.barsAmount * 2)
            barsColor1: rootItem.barsColor
            barsColor2: "#00000000"
            barsAmount: rootItem.value * rootItem.barsAmount
            barsSmoothness: rootItem.barsSmoothness
            barsDistribution: rootItem.barsDistribution
        }
    }

    // Add glow to bars
    GlowEffect {
        id: barsEffectSource
        anchors.fill: barsEffectItem
        source: barsEffectItem
        layer.enabled: true
        visible: false
        glowBlendMode: 1
        glowBloom: rootItem.glowBloom
        glowColor: rootItem.highlightColor
        glowBlurAmount: rootItem.glowBlur
    }

    // Bend the bars + glow into circle
    BendEffect {
        id: bendEffect
        anchors.centerIn: parent
        anchors.alignWhenCentered: false
        height: parent.height * (1.0 + barHeight * 0.5)
        width: parent.width * (1.0 + barHeight * 0.5)
        source: barsEffectSource
        circleBendRingWidth: rootItem.barHeight
        circleBendStartAngle: rootItem.startAngle
        circleBendSpanAngle: rootItem.spanAngle
    }
}
