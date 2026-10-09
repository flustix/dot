import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import qs.components
import qs.utils

MouseArea {
    id: root
    implicitWidth: idle.width + 16
    implicitHeight: parent.height

    hoverEnabled: true
    onClicked: m => {
        let open = Globals.panelPower;
        Globals.closePanels();
        Globals.panelPower = !open;
    }

    HoverLayer {
        area: root
        anchors.fill: parent
    }

    RowLayout {
        id: idle
        height: parent.height
        x: 8

        Text {
            visible: UPower.displayDevice.isPresent
            text: `${Math.round(UPower.displayDevice.percentage * 100)}%`
            color: Theme.text
            font.pointSize: 10
        }

        TintedIcon {
            size: 20
            path: Icons.resolve(UPower.displayDevice.isPresent ? Icons.getBattery(UPower.displayDevice) : 'battery-full')
            color: Theme.text
        }
    }
}