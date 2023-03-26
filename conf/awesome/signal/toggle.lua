local awful = require 'awful'

awesome.connect_signal("toggle::wifi", function()
  awful.spawn.with_shell("bash -c '$HOME/.config/awesome/scripts/wifi.sh --toggle'")
end)

awesome.connect_signal("toggle::bluetooth", function()
  awful.spawn.with_shell("bash -c '$HOME/.config/awesome/scripts/bluetooth.sh --toggle'")
end)

awesome.connect_signal("toggle::airplane", function()
  awful.spawn.with_shell("bash -c '$HOME/.config/awesome/scripts/airplanemode.sh'")
end)
