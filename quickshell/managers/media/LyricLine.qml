import QtQuick

import qs.managers.media

Item {
    id: root

    required property int idx

    property string text: getLine(MediaManager.playbackPosition)
    property string syncedText: ""

    property bool showing: true

    function getLine(pos: real): string {
        let idx = -1;
        let current = false;

        for (let i = 0; i < MediaManager.lyrics.length; i++) {
            let t = MediaManager.lyrics[i].Start / 10000000;
            if (pos >= t) {
                if (i % 2 == root.idx) {
                    idx = i;
                    current = true;
                } else
                    current = false;
            } else
                break;
        }

        if (idx === -1) {
            showing = false;
            return "";
        }

        let line = MediaManager.lyrics[idx];
        let text = line.Text.trim();
        syncedText = text;
        showing = current && text != "";

        if (line.Cues?.length) {
            syncedText = "";

            for (let i = 0; i < line.Cues.length; i++) {
                const c = line.Cues[i];
                const part = text.substring(c.Position, c.EndPosition)
                const start = c.Start / 10000000;

                if (start <= pos)
                    syncedText += part;
            }
        }

        return line.Text;
    }
}
