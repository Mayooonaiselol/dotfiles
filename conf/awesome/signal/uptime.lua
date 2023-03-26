local awful = require 'awful'

local update_interval = 30

local uptime_script = [[sh -c $HOME/.config/awesome/scripts/uptime.sh]]

awful.widget.watch(uptime_script, update_interval, function(_, stdout)
  local up = stdout
  awesome.emit_signal("signal::uptime", up)
end)
