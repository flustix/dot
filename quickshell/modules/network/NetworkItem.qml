import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Networking
import Quickshell.Widgets

import qs.components
import qs.managers.net
import qs.utils

MouseArea {
    id: root
    width: 400
    height: 56
    hoverEnabled: true

    required property NetworkDevice modelData

    readonly property NetworkDevice dev: modelData
    readonly property WiredDevice wired: modelData as WiredDevice
    readonly property WifiDevice wireless: modelData as WifiDevice

    readonly property Network net: wired?.network

    readonly property string readableName: {
        if (wired && net)
            return net.nmSettings.find(x => x.id)?.id;

        return dev.name;
    }

    onClicked: m => {
        if (root.dev.connected) {
            root.dev.disconnect();
        } else {
            if (wired)
                wired.network.connect();
        }
    }

    HoverLayer {
        area: root
        anchors.fill: parent

        // really really really REALLY fucking stupid way to do this because the
        // parent rectangle does not cut it off at all
        topLeftRadius: Networking.devices.values.indexOf(root.dev) == 0 ? 16 : 0
    }

    RowLayout {
        height: parent.height
        spacing: 12

        TintedIcon {
            Layout.leftMargin: 12
            size: 24
            path: Quickshell.iconPath(Icons.network(root.dev))
        }

        ColumnLayout {
            spacing: -2
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true

            RowLayout {
                Text {
                    text: root.readableName
                    color: Theme.text
                    font.pointSize: 12
                }

                Text {
                    text: root.modelData.name
                    color: Theme.subtext
                    font.pointSize: 10
                    visible: root.modelData.name != root.readableName
                }
            }

            Text {
                text: ConnectionState.toString(root.dev.state)
                color: Theme.subtext
                font.pointSize: 10
            }
        }
    }
}
