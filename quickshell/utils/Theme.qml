pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import qs.utils

Singleton {
    id: root
    Component.onCompleted: Theme.readFile()

    property string text: "#c6d0f5"
    property string hover: "#44c6d0f5"
    property string subtext: "#a5adce"
    property string base: "#303446"

    FileView {
        id: themeFile
        watchChanges: true
        blockLoading: true
        blockAllReads: true
        path: Qt.resolvedUrl(`${Quickshell.shellDir}/theme.json`)
        onFileChanged: root.readFile()
    }

    function openWallpaperSwitcher() {
        CLI.run("zsh", ["-c", "find ~/Pictures/Wallpapers -type f | sort | vicinae dmenu"], res => {
            if (!res.success)
                return;

            CLI.run("matugen", ["image", res.output, "--json", "hex", "--old-json-output"], _ => {});
        });
    }

    function readFile() {
        console.log("theme has changed");

        themeFile.reload();
        const raw = themeFile.text();
        const json = JSON.parse(raw);

        root.text = json.text;
        root.hover = json.text.replace("#", "#44");
        root.subtext = json.subtext;
        root.base = json.base;

        themeFile.watchChanges = true;
    }

    Behavior on base {
        ColorAnimation {
            duration: 500
        }
    }

    Behavior on text {
        ColorAnimation {
            duration: 500
        }
    }

    Behavior on subtext {
        ColorAnimation {
            duration: 500
        }
    }

    Behavior on hover {
        ColorAnimation {
            duration: 500
        }
    }
}
