import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

MouseArea {
    id: root
    required property SystemTrayItem modelData
    required property PanelWindow window

    width: 24
    height: 24
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

    IconImage {
        anchors.fill: parent
        source: parent.modelData.icon || "fallback-icon-name"
    }

    onClicked: m => {
        console.log(JSON.stringify(modelData));
        if (m.button === Qt.LeftButton)
            modelData.activate();
        else if (m.button === Qt.MiddleButton)
            modelData.secondaryActivate();
        else {
            const gp = root.mapToGlobal(m.x, m.y);
            console.log(gp);
            modelData.display(window, gp.x - 1440, gp.y);
        }
    }
}
