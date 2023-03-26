local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require 'gears'
local awful = require 'awful'

-- TODO: stack a gradient over the slider

local wifi_text = wibox.widget {
  text = "",
  align = "center",
  font = beautiful.icon_font .. " 32",
  widget = wibox.widget.textbox
}

local wifi = wibox.widget {
  {
    wifi_text,
    margins = dpi(30),
    widget = wibox.container.margin
  },
  bg = beautiful.blue,
  fg = beautiful.light_blue,
  widget = wibox.container.background,
  shape = helpers.rrect(10),
  buttons = {
    awful.button({}, 1, function() awesome.emit_signal('toggle::wifi') end)
  },
}

awesome.connect_signal("signal::wifi", function(is_enabled)
  wifi_text.text = is_enabled and "" or ""
  wifi.bg = is_enabled and beautiful.bg6 or beautiful.bg7
  wifi.fg = is_enabled and beautiful.light_blue or beautiful.fg
end)

local bluetooth_text = wibox.widget {
  text = "",
  align = "center",
  font = beautiful.icon_font .. " 32",
  widget = wibox.widget.textbox
}

local bluetooth = wibox.widget {
  {
    bluetooth_text,
    margins = dpi(30),
    widget = wibox.container.margin
  },
  bg = beautiful.bg6,
  fg = beautiful.light_blue,
  widget = wibox.container.background,
  shape = helpers.rrect(10),
  buttons = {
    awful.button({}, 1, function() awesome.emit_signal('toggle::bluetooth') end)
  },
}

local airplane_text = wibox.widget {
  text = "",
  align = "center",
  font = beautiful.icon_font .. " 32",
  widget = wibox.widget.textbox
}

local airplane = wibox.widget {
  {
    airplane_text,
    margins = dpi(30),
    widget = wibox.container.margin
  },
  bg = beautiful.bg6,
  fg = beautiful.light_blue,
  widget = wibox.container.background,
  shape = helpers.rrect(10),
}


local quadWidget = wibox.widget {
  {
    {
      wifi,
      bluetooth,
      airplane,
      spacing = 30,
      layout = wibox.layout.fixed.horizontal
    },
    margins = 15,
    widget = wibox.container.margin,
  },
  shape = helpers.rrect(10),
  bg = beautiful.bg4,
  widget = wibox.container.background
}

local active_color_vol = {
  type = 'linear',
  from = { 0, 0 },
  to = { 75 },
  stops = { { 0, beautiful.purple }, { 0.50, beautiful.light_purple } }
}

local volume_slider = wibox.widget {
  max_value = 100,
  value = 50,
  forced_height = dpi(85),
  forced_width = dpi(75),
  color = active_color_vol,
  background_color = beautiful.bg4,
  border_width = 0,
  border_color = beautiful.border_color,
  widget = wibox.widget.progressbar,
  buttons = {
    awful.button({}, 4, function()
      awful.spawn.with_shell("pamixer --increase 5")
    end),
    awful.button({}, 5, function()
      awful.spawn.with_shell("pamixer --decrease 5")
    end)
  }
}

local volume_label_text = wibox.widget {
  font = beautiful.font,
  valign = "top",
  halign = "center",
  widget = wibox.widget.textbox
}

local volume_label = wibox.widget {
  volume_label_text,
  margins = 10,
  widget = wibox.container.margin
}

local volume_icon_text = wibox.widget {
  font   = beautiful.icon_font .. " " .. 20,
  valign = "bottom",
  halign = "center",
  widget = wibox.widget.textbox,
}

local volume_icon = wibox.widget {
  volume_icon_text,
  margins = 10,
  widget = wibox.container.margin,
  buttons = {
    awful.button({}, 1, function() awesome.emit_signal('volume::mute') end)
  },
}

awesome.connect_signal("signal::volume", function(volume, muted)
  volume_slider.value = volume
  volume_label_text.text = volume .. '%'
  volume_icon_text.text = muted and "" or ""
end)


local volume = wibox.widget {
  {
    volume_slider,
    direction = "east",
    widget = wibox.container.rotate
  },
  volume_label,
  volume_icon,
  widget = wibox.layout.stack
}

local active_color_mic = {
  type = 'linear',
  from = { 0, 0 },
  to = { 75 },
  stops = { { 0, beautiful.pink }, { 0.50, beautiful.light_pink } }
}

local mic_slider = wibox.widget {
  max_value = 100,
  value = 50,
  forced_height = dpi(85),
  forced_width = dpi(75),
  color = active_color_mic,
  background_color = beautiful.bg4,
  border_width = 0,
  border_color = beautiful.border_color,
  widget = wibox.widget.progressbar,
  buttons = {
    awful.button({}, 4, function()
      awful.spawn.with_shell("brightnessctl s +5%")
    end),
    awful.button({}, 5, function()
      awful.spawn.with_shell("brightnessctl s 5%-")
    end)
  }
}

local mic_label_text = wibox.widget {
  font = beautiful.font,
  valign = "top",
  halign = "center",
  widget = wibox.widget.textbox
}

local mic_label = wibox.widget {
  mic_label_text,
  margins = 10,
  widget = wibox.container.margin
}

local mic_icon_text = wibox.widget {
  font   = beautiful.icon_font .. " " .. 20,
  valign = "bottom",
  halign = "center",
  widget = wibox.widget.textbox,
}

local mic_icon = wibox.widget {
  mic_icon_text,
  margins = 10,
  widget = wibox.container.margin,
  buttons = {
    awful.button({}, 1, function() awesome.emit_signal('microphone::mute') end)
  },
}

awesome.connect_signal("signal::microphone", function(mic_int, mic_muted)
  mic_slider.value = mic_int
  mic_label_text.text = mic_int .. '%'
  mic_icon_text.text = mic_muted and "" or ""
end)

local mic = wibox.widget {
  {
    mic_slider,
    direction = "east",
    widget = wibox.container.rotate
  },
  mic_label,
  mic_icon,
  widget = wibox.layout.stack
}

local active_color_bri = {
  type = 'linear',
  from = { 0, 0 },
  to = { 75 },
  stops = { { 0, beautiful.blue }, { 0.50, beautiful.light_blue } }
}

local bri_slider = wibox.widget {
  max_value = 100,
  value = 50,
  forced_height = dpi(85),
  forced_width = dpi(75),
  color = active_color_bri,
  background_color = beautiful.bg4,
  border_width = 0,
  border_color = beautiful.border_color,
  widget = wibox.widget.progressbar,
  buttons = {
    awful.button({}, 4, function()
      awful.spawn.with_shell("brightnessctl s +5%")
    end),
    awful.button({}, 5, function()
      awful.spawn.with_shell("brightnessctl s 5%-")
    end)
  }
}

local bri_label_text = wibox.widget {
  font = beautiful.font,
  valign = "top",
  halign = "center",
  widget = wibox.widget.textbox
}

local bri_label = wibox.widget {
  bri_label_text,
  margins = 10,
  widget = wibox.container.margin
}

local bri_icon = wibox.widget {
  {
    text   = "",
    font   = beautiful.icon_font .. " " .. 20,
    valign = "bottom",
    halign = "center",
    widget = wibox.widget.textbox,
  },
  margins = 10,
  widget = wibox.container.margin,
}

awesome.connect_signal("signal::brightness", function(percentage)
  bri_slider.value = percentage
  bri_label_text.text = percentage .. '%'
end)

local brightness = wibox.widget {
  {
    bri_slider,
    direction = "east",
    widget = wibox.container.rotate
  },
  bri_icon,
  bri_label,
  widget = wibox.layout.stack,
}

local triWidget = wibox.widget {
  {
    brightness,
    volume,
    mic,
    layout = wibox.layout.fixed.horizontal
  },
  shape = helpers.rrect(10),
  widget = wibox.container.background
}

local settings = wibox.widget {
  {
    quadWidget,
    widget = wibox.container.margin
  },
  {
    triWidget,
    widget = wibox.container.margin
  },
  spacing = 15,
  layout = wibox.layout.fixed.vertical
}

return settings
