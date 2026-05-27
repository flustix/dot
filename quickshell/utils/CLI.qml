pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    function run(cmd: string, args: list<string>, callback: var) {
        const proc = commandProc.createObject(root);
        proc.cmdArgs = [cmd, ...args];
        proc.callback = callback;
        Qt.callLater(() => proc.exec(proc.cmdArgs));
    }

    Component {
        id: commandProc
        CommandProcess {}
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
