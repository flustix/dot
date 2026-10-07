pragma Singleton

import Quickshell

import qs.utils

Singleton {
    id: state

    readonly property ShellScreen primaryScreen: Quickshell.screens.find(x => x.name == Config.primaryScreen) ?? Quickshell.screens[0]
    readonly property string primaryScreenId: primaryScreen?.name ?? ''

    property bool dimmed: false
    property bool locked: false

    property bool panelAudio: false
    property bool panelNetwork: false
    property bool panelMedia: false
    property bool panelPower: false

    function closePanels() {
        panelAudio = false;
        panelNetwork = false;
        panelMedia = false;
        panelPower = false;
    }
}
