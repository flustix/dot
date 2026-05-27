pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

import qs.utils

Singleton {
    id: root

    function resolve(icon: string): string {
        return Qt.resolvedUrl(`${Quickshell.shellDir}/icons/${icon}`);
    }

    function getBattery(dev: UPowerDevice): string {
        if (dev.state == UPowerDeviceState.Charging)
            return "battery-charging";

        if (dev.percentage > .9)
            return "battery-full";
        if (dev.percentage > .6)
            return "battery-high";
        if (dev.percentage > .3)
            return "battery-medium";
        if (dev.percentage > .1)
            return "battery-low";

        return "battery-empty";
    }

    function getBatteryColor(dev: UPowerDevice): string {
        if (dev.state == UPowerDeviceState.Charging)
            return "#a6d189";

        if (dev.percentage <= .2)
            return "#e78284";
        if (dev.percentage <= .4)
            return "#ef9f76";

        return Theme.text;
    }
}
