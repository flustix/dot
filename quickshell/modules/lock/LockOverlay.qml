pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pam
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts

import qs.managers.media
import qs.utils

Item {
    id: panel

    property bool finished: false
    property real transition: 0

    Behavior on transition {
        NumberAnimation {
            duration: 800
            easing: Easing.OutQuint
        }
    }

    states: [
        State {
            name: "visible"
            when: lock.locked && !panel.finished
            PropertyChanges {
                target: panel
                transition: 0
            }
        },
        State {
            name: "hidden"
            when: !lock.locked || panel.finished
            PropertyChanges {
                target: panel
                transition: 1
            }
        }
    ]

    property bool idle: true

    Timer {
        id: idleTimer
        interval: 10000
        onTriggered: panel.idle = true
    }

    function resetIdle() {
        idle = false;
        idleTimer.restart();
    }

    Timer {
        id: exitTimer
        interval: 400
        onTriggered: () => {
            Globals.locked = false;
            panel.finished = false;
            panel.idle = true;
        }
    }

    WlSessionLock {
        id: lock
        locked: Globals.locked

        WlSessionLockSurface {
            id: surface
            color: "transparent"

            ScreencopyView {
                anchors.fill: parent
                captureSource: surface.screen
            }

            Image {
                id: background
                width: parent.width
                height: parent.height
                source: Theme.image
                clip: true
                y: -height * panel.transition
                scale: panel.idle ? 1 : 1.2

                layer.enabled: true
                layer.effect: MultiEffect {
                    blurEnabled: true
                    blur: panel.idle ? 0 : 1
                    blurMax: 64

                    Behavior on blur {
                        NumberAnimation {
                            duration: 800
                            easing: Easing.OutQuint
                        }
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 800
                        easing: Easing.OutQuint
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: parent.height
                color: "black"
                opacity: panel.idle ? 0 : 0.45
                y: -height * panel.transition

                Behavior on opacity {
                    NumberAnimation {
                        duration: 400
                    }
                }
            }

            Loader {
                anchors.fill: parent
                active: surface.screen?.name == Globals.primaryScreenId
                sourceComponent: Item {
                    id: inputHandler
                    anchors.fill: parent

                    states: [
                        State {
                            name: "focused"
                            when: !panel.idle
                            PropertyChanges {
                                target: content
                                opacity: 1
                                x: 0
                            }
                            PropertyChanges {
                                target: idleContent
                                opacity: 0
                                x: -400
                            }
                        },
                        State {
                            name: "idle"
                            when: panel.idle
                            PropertyChanges {
                                target: content
                                opacity: 0
                                x: 400
                            }
                            PropertyChanges {
                                target: idleContent
                                opacity: 1
                                x: 0
                            }
                        }
                    ]

                    // IDLE TRACKING //
                    Keys.onPressed: ev => {
                        if (panel.idle)
                            passwd.text = '';

                        panel.resetIdle();
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onPressed: {
                            if (panel.idle)
                                passwd.text = '';

                            panel.resetIdle();
                            passwd.forceActiveFocus();
                        }
                    }

                    SystemClock {
                        id: clock
                        precision: SystemClock.Seconds
                    }

                    PamContext {
                        id: pam
                        onCompleted: r => {
                            if (r == PamResult.Success) {
                                panel.finished = true;
                                exitTimer.running = true;
                            }
                        }
                        onPamMessage: {
                            if (pam.message.startsWith("Password:")) {
                                pam.respond(passwd.text);
                            }
                        }
                    }

                    // IDLE CONTENT (clock, media) //
                    Item {
                        id: idleContent
                        implicitWidth: parent.width
                        implicitHeight: parent.height
                        y: -height * panel.transition

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 400
                            }
                        }

                        Behavior on x {
                            NumberAnimation {
                                duration: 800
                                easing: Easing.OutQuint
                            }
                        }

                        // CLOCK //
                        ColumnLayout {
                            spacing: -24
                            x: 96
                            y: 96

                            Text {
                                text: Qt.formatDateTime(clock.date, "hh:mm")
                                color: Theme.text
                                font.pointSize: 96
                            }

                            Text {
                                text: Qt.formatDateTime(clock.date, "dd MMM yyyy")
                                color: Theme.subtext
                                font.pointSize: 24
                            }
                        }

                        // MEDIA //
                        RowLayout {
                            visible: MediaManager.playing
                            x: 96
                            y: parent.height - height - 96
                            spacing: 16

                            ClippingWrapperRectangle {
                                implicitWidth: 96
                                implicitHeight: 96
                                radius: 4
                                clip: true
                                color: "transparent"

                                transformOrigin: Item.Center
                                rotation: -3

                                Image {
                                    anchors.fill: parent
                                    source: Qt.resolvedUrl(MediaManager.cover)
                                    fillMode: Image.PreserveAspectCrop
                                }
                            }

                            ColumnLayout {
                                spacing: 0

                                Text {
                                    text: MediaManager.title
                                    color: Theme.text
                                    font.pointSize: 16
                                }

                                Text {
                                    text: MediaManager.artist
                                    color: Theme.subtext
                                    font.pointSize: 14
                                }
                            }
                        }
                    }

                    // IDLE CONTENT DROPSHADOW //
                    MultiEffect {
                        source: idleContent
                        anchors.fill: idleContent
                        opacity: idleContent.opacity

                        shadowEnabled: true
                        shadowColor: "#3f000000"
                        shadowHorizontalOffset: 3
                        shadowVerticalOffset: 4
                        shadowBlur: 0.5
                    }

                    // FORM //
                    Item {
                        id: content
                        implicitWidth: parent.width
                        implicitHeight: parent.height
                        y: -height * panel.transition

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 400
                            }
                        }

                        Behavior on x {
                            NumberAnimation {
                                duration: 800
                                easing: Easing.OutQuint
                            }
                        }

                        ColumnLayout {
                            id: form
                            width: 240
                            anchors.centerIn: parent
                            spacing: 16

                            property string username: Quickshell.env("USER")
                            property string name: Quickshell.env("USER")

                            property string avatar: `/var/lib/AccountsService/icons/${username}.face.icon`

                            Component.onCompleted: {
                                CLI.run("sh", ["-c", "busctl get-property org.freedesktop.Accounts /org/freedesktop/Accounts/User$(id -u) org.freedesktop.Accounts.User RealName"], res => {
                                    if (!res.success)
                                        return;

                                    let raw = res.output.trim();
                                    let match = raw.match(/^s "(.*)"$/);

                                    if (match && match[1].length > 0) {
                                        form.name = match[1];
                                    }
                                });
                            }

                            ClippingWrapperRectangle {
                                Layout.alignment: Qt.AlignHCenter
                                implicitWidth: 160
                                implicitHeight: 160
                                radius: width / 2
                                clip: true
                                color: "transparent"

                                Image {
                                    anchors.fill: parent
                                    source: Qt.resolvedUrl(form.avatar)
                                    fillMode: Image.PreserveAspectCrop
                                }
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: form.name
                                color: Theme.text
                                font.pointSize: 20
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                height: 48
                                color: Theme.base
                                radius: 12

                                MarginWrapperManager {
                                    margin: 18
                                }

                                TextInput {
                                    id: passwd
                                    echoMode: TextInput.Password
                                    font.pixelSize: 14
                                    color: Theme.text
                                    focus: true
                                    onAccepted: {
                                        pam.start();
                                    }

                                    Component.onCompleted: passwd.forceActiveFocus()
                                    Keys.forwardTo: [inputHandler]
                                }
                            }
                        }
                    }
                }
            }

            /* Button {
                width: 100
                height: 32
                text: 'failsafe'
                onClicked: {
                    panel.finished = true;
                    exitTimer.running = true;
                }
            } */
        }
    }
}
