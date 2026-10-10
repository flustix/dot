import QtQuick
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

import qs.utils

Item {
    property string path: ""
    property real size: 24
    property string color: Theme.text
    property bool effect: false

    width: size
    height: size

    Image {
        id: icon
        anchors.fill: parent
        source: parent.path
        visible: false
    }

    MultiEffect {
        visible: parent.effect
        source: icon
        anchors.fill: icon

        colorization: 1.0
        colorizationColor: parent.color
    }

    ColorOverlay {
        visible: !parent.effect
        anchors.fill: icon
        source: icon
        color: parent.color
    }
}
