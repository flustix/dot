pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: format

    function remap(value, min, max) {
        var t = (value - min) / (max - min);
        t = Math.max(0, Math.min(t, 1));
        return t;
    }

    function duration(secs, short = true, showSeconds = true) {
        let days = Math.floor(secs / 86400);
        let hours = Math.floor(secs / 3600) % 24;
        let minutes = Math.floor(secs / 60) % 60;
        let seconds = Math.floor(secs % 60);

        let result = "";

        if (short) {
            if (days > 0) result += days + 'd ';
            if (hours > 0) result += hours + 'h ';
            if (minutes > 0) result += minutes + 'm ';
            if (seconds >= 30 && showSeconds) result += seconds + 's ';
        } else {
            if (days > 0) result += days > 1 ? days + ' days ' : days + ' day ';
            if (hours > 0) result += hours > 1 ? hours + ' hours ' : hours + ' hour ';
            if (minutes > 0) result += minutes > 1 ? minutes + ' minutes ' : minutes + ' minute ';
            if (seconds >= 30 && showSeconds) result += seconds > 1 ? seconds + ' seconds' : seconds + ' second';
        }

        return result.trim() || 'now';
    }
}