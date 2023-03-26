local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')

local status_old = -1
local function emit_network_status()
  awful.spawn.easy_async_with_shell(
    "bash -c 'nmcli networking connectivity check'", function(stdout)
    local status    = not stdout:match("none") -- boolean
    local status_id = status and 1 or 0 -- integer
    if status_id ~= status_old then
      awesome.emit_signal('signal::network', status)
      status_old = status_id
    end
    -- if status == 1 then
    --   awful.spawn.easy_async_with_shell("nmcli device status | grep wlo1 | awk '{print $4}'", function(out)
    --     naughty.notify({title = "Wi-Fi", text = "Connected to " .. out})
    --   end)
    -- end
  end)
end

local wifi_old = -1
local function emit_wifi_status()
  awful.spawn.easy_async_with_shell(
    "bash -c 'nmcli radio wifi'", function(stdout)
    local wifi_status = stdout:match("enabled")
    local wifi_status_id = wifi_status and 1 or 0 -- integer
    if wifi_status_id ~= wifi_old then
      awesome.emit_signal('signal::wifi', wifi_status)
      wifi_old = wifi_status_id
    end
  end)
end

-- Refreshing
-------------
gears.timer {
  timeout   = 5,
  call_now  = true,
  autostart = true,
  callback  = function()
    emit_network_status()
    emit_wifi_status()
  end
}
