pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects

import qs.utils

Item {
    id: root

    property string color: Theme.base

    property real topLeft: 0
    property real topRight: 0
    property real bottomLeft: 0
    property real bottomRight: 0

    Rectangle {
        anchors.fill: parent
        color: parent.color

        layer.enabled: true
        layer.effect: MultiEffect {
            maskSource: mask
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }

    Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            anchors.fill: parent
            topLeftRadius: root.topLeft
            topRightRadius: root.topRight
            bottomLeftRadius: root.bottomLeft
            bottomRightRadius: root.bottomRight
        }
    }
}
