local awful = require "awful"

local update_interval = 10

local bat_subscribe_script = [[
   bash -c "
   while (inotifywait -e modify /sys/class/power_supply/BAT1/capacity /sys/class/power_supply/BAT1/status -qq) do echo; done
"]]

-- TODO: separate capacity and status
local bat_script = [[sh -c ' echo "$(cat /sys/class/power_supply/BAT1/capacity)" "$(cat /sys/class/power_supply/BAT1/status)" ']]

-- local bat_emit = function()
--   awful.spawn.with_line_callback(bat_script, function(_, stdout)
--     local capacity = string.sub(stdout, 1, 3)
--     local status = string.sub(stdout, 4)
--     awesome.emit_signal("signal::battery", tonumber(string.format("%.0f", capacity)), status)

--   )
-- end

awful.widget.watch(bat_script, update_interval, function(_, stdout)
  local capacity = string.sub(stdout, 1, 3)
  local status = string.sub(stdout, 4)
  awesome.emit_signal("signal::battery", tonumber(string.format("%.0f", capacity)), status)
end)
