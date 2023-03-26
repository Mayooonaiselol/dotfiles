local awful = require("awful")

-- Subscribe to backlight changes
-- Requires inotify-tools
local brightness_subscribe_script = [[
   bash -c "
   while (inotifywait -e modify /sys/class/backlight/?*/brightness -qq) do echo; done
"]]

local brightness_script = [[
   sh -c "
   brightnessctl -m -d intel_backlight | cut -d, -f4 | tr -d %
"]]

local brightness_emit = function()
    awful.spawn.with_line_callback(brightness_script, {
        stdout = function(line)
            percentage = math.floor(tonumber(line))
            awesome.emit_signal("signal::brightness", percentage)
        end
    })
end

-- Run once to initialize widgets
brightness_emit()

-- Kill old inotifywait process
awful.spawn.easy_async_with_shell("ps x | grep \"inotifywait -e modify /sys/class/backlight\" | grep -v grep | awk '{print $1}' | xargs kill", function ()
    -- Update brightness status with each line printed
    awful.spawn.with_line_callback(brightness_subscribe_script, {
        stdout = function(_)
            brightness_emit()
        end
    })
end)
