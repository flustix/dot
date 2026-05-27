import QtQuick
import QtQuick.Effects

import qs.utils

Item {
    property string path: ""
    property real size: 24
    property string color: Theme.text

    width: size
    height: size

    Image {
        id: icon
        anchors.fill: parent
        source: parent.path
        visible: false
    }

    MultiEffect {
        source: icon
        anchors.fill: icon
        colorization: 1.0
        colorizationColor: parent.color
    }
}
