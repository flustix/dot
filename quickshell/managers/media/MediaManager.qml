pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick

import qs.utils

Singleton {
    id: music

    readonly property int pollRate: 50

    property string preferredPlayer: "Finamp"
    property MprisPlayer player: Mpris.players.values.length > 0 ? Mpris.players.values.find(x => x.identity == preferredPlayer) || Mpris.players.values[0] : null

    Component.onCompleted: downloadLyrics(player?.trackTitle, player?.trackArtist)

    property var lyrics: []
    property var playbackPosition: 0.0

    readonly property bool showingLyrics: playing && (lr1.showing || lr2.showing)
    property alias lr1: lr1
    property alias lr2: lr2

    readonly property string title: player?.trackTitle || "no title"
    readonly property string artist: player?.trackArtist || "no artist"
    readonly property string cover: player?.trackArtUrl || ""

    readonly property bool playing: player?.isPlaying || false
    readonly property bool shuffle: player?.shuffle || false
    readonly property int repeat: player?.loopState ?? 0

    LyricLine {
        id: lr1
        idx: 0
    }

    LyricLine {
        id: lr2
        idx: 1
    }

    // lyrics
    Connections {
        target: music.player
        
        function onTrackTitleChanged() {
            music.lyrics = [];
            if (music.player?.trackTitle) {
                music.downloadLyrics(music.player.trackTitle, music.player.trackArtist.split(',')[0]);
            }
        }
    }

    function downloadLyrics(title: string, artist: string) {
        console.log(`[music] changed track to ${title} - ${artist}`);

        if (!title || !artist)
            return;

        CLI.jellyfin(`/Items?recursive=true&includeItemTypes=Audio&artists=${encodeURIComponent(artist)}&searchTerm=${encodeURIComponent(title)}`, r => {
            if (!r.success)
                return;

            let res = JSON.parse(r.output);
            if (res.Items.length) {
                let item = res.Items[0];
                let id = item.Id;

                CLI.jellyfin(`/Audio/${id}/Lyrics`, lyrRes => {
                    if (!lyrRes.success)
                        return;

                    let lyr = JSON.parse(lyrRes.output);

                    if (!lyr.Lyrics?.length || !lyr.Lyrics[0].Start)
                        return;

                    console.log(`[music] Loaded ${lyr.Lyrics.length} lyric lines.`);
                    music.lyrics = lyr.Lyrics;
                })
            }
        })
    }

    Timer {
        id: positionTimer
        interval: music.pollRate
        running: music.player
        repeat: true
        onTriggered: music.getPosition()
    }

    function getPosition() {
        playerctlPosition.command = ["playerctl", "-p", player?.dbusName.replace("org.mpris.MediaPlayer2.", ""), "position"];
        playerctlPosition.running = true;
    }

    Process {
        id: playerctlPosition
        command: ["playerctl", "position"]
        stdout: StdioCollector {
            onStreamFinished: music.playbackPosition = parseFloat(this.text)
        }
    }
}
