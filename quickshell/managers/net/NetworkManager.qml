pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property list<NetworkConnection> connections: []
    property bool active: connections.find(x => x.connected) != null

    function up(id: string) {
        runCommand(["dev", "up", id], _ => {});
    }

    function down(id: string) {
        runCommand(["dev", "down", id], _ => {});
    }

    function fetchNetworks() {
        runCommand(["-t", "-f", "DEVICE,STATE,CONNECTION,TYPE", "dev"], res => {
            connections = [];

            for (let line of res.output.split("\n")) {
                let split = line.split(":");

                let id = split[0];
                let state = split[1];
                let name = split[2];
                let type = split[3];

                if (id == "lo" || type == "bridge" || id.startsWith("veth"))
                    continue;

                var conn = cnComp.createObject(root);
                conn.name = name;
                conn.state = state;
                conn.id = id;
                connections.push(conn);
            }
        });
    }

    function runCommand(args: list<string>, callback: var) {
        const proc = commandProc.createObject(root);
        proc.cmdArgs = ["nmcli", ...args];
        proc.callback = callback;

        /* activeProcesses.push(proc);

        proc.processFinished.connect(() => {
            const index = activeProcesses.indexOf(proc);
            if (index >= 0) {
                activeProcesses.splice(index, 1);
            }
        }); */

        Qt.callLater(() => {
            proc.exec(proc.cmdArgs);
        });
    }

    Process {
        id: procMonitor
        command: ["nmcli", "monitor"]
        running: true
        stdout: SplitParser {
            onRead: root.fetchNetworks()
        }
    }

    Component {
        id: commandProc
        CommandProcess {}
    }

    Component {
        id: cnComp
        NetworkConnection {}
    }

    component CommandProcess: Process {
        id: proc

        property var callback: null
        property list<string> cmdArgs: []
        property bool callbackCalled: false
        property int exitCode: 0

        signal processFinished

        environment: ({
                LANG: "C.UTF-8",
                LC_ALL: "C.UTF-8"
            })

        stdout: StdioCollector {
            id: stdoutCollector
        }

        stderr: StdioCollector {
            id: stderrCollector

            onStreamFinished: {
                const error = text.trim();
                if (error && error.length > 0) {
                    console.log(error);
                }
            }
        }

        onExited: code => { // qmllint disable signal-handler-parameters
            exitCode = code;

            Qt.callLater(() => {
                if (callbackCalled) {
                    processFinished();
                    return;
                }

                if (proc.callback) {
                    const output = (stdoutCollector && stdoutCollector.text) ? stdoutCollector.text.trim() : "";
                    const error = (stderrCollector && stderrCollector.text) ? stderrCollector.text : "";
                    const success = exitCode === 0;

                    callbackCalled = true;
                    callback({
                        success: success,
                        output: output,
                        error: error,
                        exitCode: proc.exitCode
                    });
                    processFinished();
                } else {
                    processFinished();
                }
            });
        }
    }
}
