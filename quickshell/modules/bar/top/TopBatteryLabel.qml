import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import qs.components
import qs.utils

MouseArea {
    id: root
    implicitWidth: (idle.width + (status.width - idle.width) * statusAnim.move) + 16
    implicitHeight: parent.height

    hoverEnabled: true
    onClicked: m => {
        let open = Globals.panelPower;
        Globals.closePanels();
        Globals.panelPower = !open;
    }

    readonly property UPowerDevice dev: UPower.displayDevice
    readonly property int state: dev?.state

    property string statusUpdateText: ""
    property bool showingStatusUpdate: false

    FluidAnimation {
        id: statusAnim
        state: showingStatusUpdate
    }

    function setStatusUpdate(text) {
        statusUpdateText = text;
        showingStatusUpdate = true;
        statusUpdateIdle.running = true
    }

    onStateChanged: {
        if (state == UPowerDeviceState.Charging) {
            setStatusUpdate("Started Charging");
        } else if (state == UPowerDeviceState.Discharging) {
            setStatusUpdate("Stopped Charging")
        } else if (state == UPowerDeviceState.FullyCharged) {
            setStatusUpdate("Finished Charging")
        }
    } 

    Timer {
        id: statusUpdateIdle
        interval: 2000
        onTriggered: root.showingStatusUpdate = false
    }

    HoverLayer {
        area: root
        anchors.fill: parent
    }

    RowLayout {
        id: idle
        height: parent.height
        x: 8
        opacity: 1 - Formatting.remap(statusAnim.opacity, 0, .75)

        property var col: root.dev.isPresent ? Icons.getBatteryColor(root.dev) : Theme.text;

        Text {
            visible: root.dev.isPresent
            text: `${Math.floor(root.dev.percentage * 100)}%`
            color: idle.col
            font.pointSize: 10
        }

        TintedIcon {
            size: 20
            path: Icons.resolve(root.dev.isPresent ? Icons.getBattery(root.dev) : 'battery-full')
            color: idle.col
        }
    }

    RowLayout {
        id: status
        height: parent.height
        x: 8
        opacity: Formatting.remap(statusAnim.opacity, .25, 1)

        Text {
            text: root.statusUpdateText
            color: Theme.text
            font.pointSize: 10
        }
    }
}