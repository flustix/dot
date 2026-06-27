hl.workspace_rule({ workspace = "1", persistent = true, monitor = "HDMI-A-2" })
hl.workspace_rule({ workspace = "2", persistent = true, monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", persistent = true, monitor = "HDMI-A-1" })

for i = 4, 15, 1 do
    hl.workspace_rule({ workspace = tostring(i), persistent = true })
end
