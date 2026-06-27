hl.on("hyprland.start", function()
    -- visual layers --
    hl.exec_cmd("awww-daemon");
    hl.exec_cmd("quickshell");
    hl.exec_cmd("vicinae server");

    -- background --
    hl.exec_cmd("kdeconnectd");
    hl.exec_cmd("/usr/bin/openrgb --startminimized");
    hl.exec_cmd("systemctl --user start hyprpolkitagent");
    hl.exec_cmd("WEBKIT_DISABLE_COMPOSITING_MODE=1 rquickshare");
    hl.exec_cmd("snappy-switcher --daemon");

    -- foreground --
    hl.exec_cmd(
        "vesktop --enable-blink-features=MiddleClickAutoscroll --disable-features=WebRtcAllowInputVolumeAdjustment");
    hl.exec_cmd("steam -silent --disable-features=WebRtcAllowInputVolumeAdjustment");
end)

hl.on("workspace.active", function(w)
    -- hl.notification.create({ text = tostring(w.id), timeout = 2000 })
end)
