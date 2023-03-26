local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local gears = require 'gears'
local helpers = require 'helpers'
local dpi = beautiful.xresources.apply_dpi
require 'vars'

local function get_sound()
  return awful.screen.focused().sound
end

local vol_slider = wibox.widget {
  bar_shape = helpers.rrect(5),
  bar_height = 7,
  bar_color = beautiful.bg1,
  bar_active_color = beautiful.blue,
  handle_border_width = 2,
  handle_border_color = beautiful.bg,
  handle_shape = gears.shape.circle,
  handle_color = beautiful.fg_minimize,
  handle_width = 14,
  forced_height = 10,
  value = 25,
  maximum = 100,
  widget = wibox.widget.slider,
}

helpers.add_hover_cursor(vol_slider, "hand2")

local volIcon = wibox.widget {
  font = beautiful.icon_font .. " 18",
  markup = "",
  valign = "center",
  halign = "center",
  widget = wibox.widget.textbox,
}

local volLabel = wibox.widget {
  font = beautiful.font_bold,
  markup = "86" .. "%",
  valign = "center",
  widget = wibox.widget.textbox,
}

local volIconBox = wibox.widget {
  volIcon,
  right = dpi(15),
  widget = wibox.container.margin,
  buttons = {
    awful.button({}, 1, function() awesome.emit_signal('volume::mute') end)
  }
}

local volLabelBox = wibox.widget {
  volLabel,
  left = dpi(15),
  widget = wibox.container.margin
}

awesome.connect_signal("signal::volume", function(volume, muted)
  vol_slider.value = volume
  volIcon.markup   = muted and "" or ""
end)

local vol_slider_widget = wibox.widget {
  volIconBox,
  vol_slider,
  volLabelBox,
  layout = wibox.layout.align.horizontal,
  spacing = 15,
}

vol_slider:connect_signal("mouse::enter", function()
  awesome.disconnect_signal("signal::volume", function(volume, muted)
    vol_slider.value = volume
    volIcon.markup   = muted and "" or ""
  end)
  awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
    local vol_value = string.gsub(stdout, "^%s*(.-)%s*$", "%1")
    vol_slider.value = tonumber(vol_value)
  end)
end)

vol_slider:connect_signal("mouse::leave", function()
  awesome.connect_signal("signal::volume", function(volume, muted)
    vol_slider.value = volume
    volIcon.markup   = muted and "" or ""
  end)
end)

vol_slider:connect_signal("property::value", function(_, value)
  vol_slider.value = value
  volLabel.markup  = value .. '%'
  awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. value .. "%", false)
end)

local mic_slider = wibox.widget {
  bar_shape = helpers.rrect(5),
  bar_height = 7,
  bar_color = beautiful.bg1,
  bar_active_color = beautiful.blue,
  handle_border_width = 2,
  handle_border_color = beautiful.bg,
  handle_shape = gears.shape.circle,
  handle_color = beautiful.fg_minimize,
  handle_width = 14,
  value = 25,
  maximum = 100,
  forced_height = 10,
  widget = wibox.widget.slider,
}

helpers.add_hover_cursor(mic_slider, "hand2")

local micIcon = wibox.widget {
  font = beautiful.icon_font .. " 18",
  markup = "",
  valign = "center",
  halign = "center",
  widget = wibox.widget.textbox,
}

local micLabel = wibox.widget {
  font = beautiful.font_bold,
  markup = "86" .. "%",
  valign = "center",
  widget = wibox.widget.textbox,
}

local micIconBox = wibox.widget {
  micIcon,
  right = dpi(15),
  widget = wibox.container.margin,
  buttons = {
    awful.button({}, 1, function() awesome.emit_signal('microphone::mute') end)
  }
}

local micLabelBox = wibox.widget {
  micLabel,
  left = dpi(15),
  widget = wibox.container.margin
}

awesome.connect_signal("signal::microphone", function(mic_int, mic_muted)
  mic_slider.value = mic_int
  micLabel.markup  = mic_int .. '%'
  micIcon.markup   = mic_muted and "" or ""
end)

local mic_slider_widget = wibox.widget {
  micIconBox,
  mic_slider,
  micLabelBox,
  layout = wibox.layout.align.horizontal,
  spacing = 15,
}

mic_slider:connect_signal("property::value", function(_, value)
  awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ " .. value .. "%")
end)

local sound_control = wibox.widget {
  {
    markup = "Open Sound Settings",
    align = "center",
    widget = wibox.widget.textbox
  },
  fg = beautiful.blue,
  widget = wibox.container.background,
  buttons = {
    awful.button({}, 1, function() awesome.spawn(volsettings) end)
  }
}

awesome.connect_signal('sound::toggle', function()
  get_sound().toggle()
end)

awesome.connect_signal('sound::visibility', function(v)
  if v then
    get_sound().show()
  else
    get_sound().hide()
  end
end)

awful.screen.connect_for_each_screen(function(s)
  s.sound = {}

  s.sound.widget = wibox.widget {
    {
      {
        vol_slider_widget,
        mic_slider_widget,
        sound_control,
        spacing = 12,
        layout = wibox.layout.fixed.vertical,
      },
      margins = dpi(12),
      widget = wibox.container.margin,
    },
    bg = beautiful.bg,
    fg = beautiful.fg,
    widget = wibox.container.background,
    shape = helpers.rrect(5),
  }

  s.sound.popup = awful.popup {
    widget = s.sound.widget,
    screen = s,
    visible = false,
    ontop = true,
    bg = beautiful.bg .. '00',
    fg = beautiful.fg,
    maximum_width = dpi(250),
    maximum_height = dpi(125),
    shape = helpers.rrect(5),
    border_width = 1,
    border_color = beautiful.bg1,
    placement = function(d)
      return awful.placement.bottom_right(d, {
        margins = {
          right = beautiful.useless_gap * 10,
          bottom = 60,
        }
      })
    end,
  }

  local self, sound = s.sound.popup, s.sound

  function sound.toggle()
    if self.visible then
      sound.hide()
    else
      sound.show()
    end
  end

  function sound.show()
    self.visible = true
  end

  function sound.hide()
    self.visible = false
  end

  self:connect_signal("mouse::leave", function()
    self.visible = false
  end)
end)
