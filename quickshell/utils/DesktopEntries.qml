pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: desktop

    property var mapping: ({})

    Component.onCompleted: {
        CLI.run("find", [
            "/usr/share/applications",
            "/usr/local/share/applications",
            "/var/lib/flatpak/exports/share/applications",
            "~/.local/share/applications",
            "~/.local/share/flatpak/exports/share/applications",
            "-name", "*.desktop"
        ], r1 => {
            var entries = r1.output.split("\n")

            for (const entry of entries) {
                const id = entry.split("/").pop().replace(".desktop", "");

                CLI.run("cat", [entry], r2 => {
                    var lines = r2.output.split("\n");

                    for (const line of lines) {
                        if (line.startsWith("Name=")) {
                            desktop.mapping[id] = line.substring(5)
                            break;
                        }
                    }
                })
            }
        })
    }
}