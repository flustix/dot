import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components

MouseArea {
    id: root
    height: 32

    property string icon: "wifi-high"

    RowLayout {
        anchors.fill: parent

        TintedIcon {
            Layout.alignment: Qt.AlignCenter
            size: 24
            path: Qt.resolvedUrl(`${Quickshell.shellDir}/icons/${root.icon}`)
        }
    }
}
