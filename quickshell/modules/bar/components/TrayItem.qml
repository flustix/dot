import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Controls

import qs.components

MouseArea {
    id: root
    required property SystemTrayItem modelData
    required property PanelWindow window

    width: 24
    height: 24
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

    hoverEnabled: true
    readonly property string title: modelData.tooltipTitle || modelData.title

    Tooltip {
        visible: root.containsMouse && root.title
        text: root.title
    }

    TintedIcon {
        anchors.fill: parent
        path: parent.modelData.icon
        effect: true
    }

    onClicked: m => {
        if (m.button === Qt.LeftButton)
            modelData.activate();
        else if (m.button === Qt.MiddleButton)
            modelData.secondaryActivate();
        else {
            const gp = root.mapToGlobal(m.x, m.y);
            modelData.display(window, gp.x - window.screen.x, gp.y);
        }
    }
}
