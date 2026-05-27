import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import qs.utils

// qmllint disable uncreatable-type
PanelWindow {
    id: root
    WlrLayershell.namespace: "qs-notify"
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore
    mask: Region {
        item: container
    }
    focusable: false
    anchors {
        top: true
        left: true
        right: true
    }

    color: "transparent"
    implicitHeight: container.height + paddingTop
    implicitWidth: container.width + 32

    readonly property bool fullscreen: Hypr.isFullscreen(screen)
    property int paddingTop: fullscreen ? 0 : 12

    property var currentNotification: null
    property int yOffset: currentNotification ? 0 : -(container.height + paddingTop)
    property int cornerRadius: currentNotification ? 16 : 0

    Behavior on yOffset {
        NumberAnimation {
            duration: 800
            easing.type: Easing.OutQuint
        }
    }
    Behavior on cornerRadius {
        NumberAnimation {
            duration: 800
            easing.type: Easing.OutQuint
        }
    }
    Behavior on paddingTop {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutQuint
        }
    }

    function showNotification(a: string, s: string, b: string, i: string) {
        let notif = {
            app: a || "System",
            summary: s || "",
            body: b || "",
            icon: i.replace("file://", "") || ""
        };

        if (notif.body.length > 96)
            notif.body = notif.body.substring(0, 93) + "...";

        notificationQueue.append(notif);

        if (!currentNotification)
            showNext();
    }

    function showNext() {
        if (notificationQueue.count == 0) {
            currentNotification = null;
            return;
        }

        currentNotification = notificationQueue.get(0);
        timeout.restart();
    }

    function dismiss() {
        if (notificationQueue.count > 0) {
            notificationQueue.remove(0);
        }

        currentNotification = null;

        if (notificationQueue.count > 0) {
            nextNotification.start();
        }
    }

    Item {
        anchors {
            horizontalCenter: parent.horizontalCenter
        }

        width: container.width + 32
        height: container.height + 16

        /* Rectangle {
            anchors.fill: parent
            color: "#55ffffff"
        } */

        Item {
            y: root.yOffset
            MarginWrapperManager {
                topMargin: root.paddingTop
                leftMargin: 16
                rightMargin: 16
            }

            Rectangle {
                id: container
                color: Theme.base
                bottomLeftRadius: root.cornerRadius
                bottomRightRadius: root.cornerRadius

                MarginWrapperManager {
                    leftMargin: 16
                    rightMargin: 32
                    topMargin: 16 - root.paddingTop
                    bottomMargin: 16
                }

                RowLayout {
                    spacing: 12

                    Rectangle {
                        width: 36
                        height: 36
                        color: Theme.text
                        radius: 8

                        Image {
                            anchors.fill: parent
                            source: root.currentNotification?.icon
                            fillMode: Image.PreserveAspectFit
                        }

                        Text {
                            text: "󰵙"
                            color: Theme.base
                            anchors.centerIn: parent
                            font.pointSize: 14
                            visible: parent.children[0].status !== Image.Ready
                        }
                    }

                    ColumnLayout {
                        spacing: 0

                        Text {
                            text: root.currentNotification?.summary
                            color: Theme.subtext
                            font.pointSize: 10
                        }

                        Text {
                            text: root.currentNotification?.body
                            color: Theme.text
                            font.pointSize: 12
                        }
                    }
                }
            }
        }

        CornerRadius {
            implicitHeight: 32
            implicitWidth: 32
            topRight: root.cornerRadius
            color: Theme.base

            x: -16
            y: root.paddingTop
        }

        CornerRadius {
            implicitHeight: 32
            implicitWidth: 32
            topLeft: root.cornerRadius
            color: Theme.base

            x: parent.width - 16
            y: root.paddingTop
        }
    }

    ListModel {
        id: notificationQueue
    }

    Timer {
        id: timeout
        interval: 8000
        onTriggered: root.dismiss()
    }

    Timer {
        id: nextNotification
        interval: 800
        onTriggered: root.showNext()
    }

    Process {
        id: listener
        running: true
        command: ["/media/development/flustix/bar/hyprflux.Scripts/bin/Debug/net9.0/hyprflux.Scripts", "notification"]
        stdout: StdioCollector {
            onStreamFinished: {
                let text = this.text.trim();
                console.log(text);
                const json = JSON.parse(text);
                root.showNotification(json.app, json.summary, json.body, json.icon);

                listener.running = false;
                listener.running = true;
            }
        }
    }
}
