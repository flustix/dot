pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Region {
    id: root

    required property Outline window
    required property Item bar
    property OutlinePanels panels

    x: 0
    y: 0
    width: window.width
    height: window.height - bar.height
    intersection: Intersection.Xor

    R {
        target: root.panels?.media
    }

    component R: Region {
        required property Item target

        x: target?.x ?? 0
        y: target?.y ?? 0
        width: target?.width ?? 0
        height: target?.height ?? 0
        intersection: Intersection.Subtract
    }
}
