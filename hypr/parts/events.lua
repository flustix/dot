hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")

    -- visual layers --
    hl.exec_cmd("awww-daemon");
    hl.exec_cmd("quickshell");
    hl.exec_cmd("vicinae server");

    -- background --
    hl.exec_cmd("kdeconnectd");
    hl.exec_cmd("gio launch /home/flux/.config/autostart/OpenRGB.desktop");
    hl.exec_cmd("systemctl --user start hyprpolkitagent");
    hl.exec_cmd("snappy-switcher --daemon");

    -- foreground --
    hl.exec_cmd(
        "discord --start-minimized --enable-blink-features=MiddleClickAutoscroll --disable-features=WebRtcAllowInputVolumeAdjustment");
    hl.exec_cmd("steam -silent --disable-features=WebRtcAllowInputVolumeAdjustment");
end)

hl.on("window.open", function(w)
    ---@type HL.Window
    local window = w;

    if window.class == "hyprpolkitagent" then
        hl.exec_cmd(
            "pw-play --media-role=Notification /media/development/ppy/osu-resources/osu.Game.Resources/Samples/UI/dialog-pop-in.wav")
    end
end)

hl.on("workspace.active", function(w)
    -- hl.notification.create({ text = tostring(w.id), timeout = 2000 })
end)

hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)
