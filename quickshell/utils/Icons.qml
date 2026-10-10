pragma Singleton

import Quickshell
import Quickshell.Networking
import Quickshell.Services.UPower
import QtQuick

import qs.utils

Singleton {
    id: root

    function resolve(icon: string): string {
        return Qt.resolvedUrl(`${Quickshell.shellDir}/icons/${icon}`);
    }

    function network(net: NetworkDevice): string {
        if (!net) return "network-wired-offline-symbolic";

        if (net.type == DeviceType.Wireless) { 
            switch (net.state) {
                case ConnectionState.Connected:
                    return "network-wireless-symbolic";
                case ConnectionState.Connecting:
                case ConnectionState.Disconnecting:
                    return "network-wireless-acquiring-symbolic";
                case ConnectionState.Disconnected:
                    return "network-wireless-disconnected-symbolic";
                case ConnectionState.Unknown:
                    return "network-wireless-no-route-symbolic";
            }
        } else if (net.type == DeviceType.Wired) {
            switch (net.state) {
                case ConnectionState.Connected:
                    return "network-wired-symbolic";
                case ConnectionState.Connecting:
                case ConnectionState.Disconnecting:
                    return "network-wired-acquiring-symbolic";
                case ConnectionState.Disconnected:
                    return "network-wired-disconnected-symbolic";
                case ConnectionState.Unknown:
                    return "network-wired-no-route-symbolic";
            }
        }
    }

    function getBattery(dev: UPowerDevice): string {
        if (dev.state == UPowerDeviceState.Charging)
            return "battery-charging";

        if (dev.percentage > .75)
            return "battery-full-symbolic";
        if (dev.percentage > .50)
            return "battery-good-symbolic";
        if (dev.percentage > .25)
            return "battery-low-symbolic";

        return "battery-empty-symbolic";
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

    function volume(num) {
        if (num >= .5)
            return "speaker-high";
        if (num >= .25)
            return "speaker-low";
        if (num > 0)
            return "speaker-none";

        return "speaker-x";
    }
}
