hl.on("hyprland.start", function()
    -- visual layers --
    hl.exec_cmd("swww-daemon");
    hl.exec_cmd("quickshell");
    hl.exec_cmd("vicinae server");

    -- background --
    hl.exec_cmd("kdeconnectd");
    hl.exec_cmd("systemctl --user start hyprpolkitagent");
    hl.exec_cmd("WEBKIT_DISABLE_COMPOSITING_MODE=1 rquickshare");

    -- foreground --
    hl.exec_cmd(
        "discord --enable-blink-features=MiddleClickAutoscroll --disable-features=WebRtcAllowInputVolumeAdjustment");
    hl.exec_cmd("steam -silent --disable-features=WebRtcAllowInputVolumeAdjustment");
end)
