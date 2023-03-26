local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require 'gears'
local dpi = beautiful.xresources.apply_dpi
local awful = require 'awful'
require 'vars'

local imguser = wibox.widget {
  image = beautiful.profile,
  resize = true,
  forced_height = 90,
  forced_width = 90,
  clip_shape = gears.shape.circle,
  halign = "center",
  widget = wibox.widget.imagebox
}

local date_day = wibox.widget({
  {
    font = beautiful.font,
    format = "%A, %d %B %Y",
    valign = "center",
    widget = wibox.widget.textclock
  },
  fg = beautiful.fg_minimize,
  widget = wibox.container.background
})

local uptime = wibox.widget {
  text   = "Uptime unknown...",
  widget = wibox.widget.textbox
}

local uptime_widget = wibox.widget {
  uptime,
  fg = beautiful.fg_minimize,
  widget = wibox.container.background
}

awesome.connect_signal("signal::uptime", function(up)
  uptime.text = up
end)

local text = wibox.widget {
  markup = "<b>Hi,</b> " .. os.getenv('USER') .. "!",
  font = beautiful.font .. " 20",
  valign = "center",
  widget = wibox.widget.textbox
}

local info = wibox.widget({
  {
    {
      text,
      date_day,
      uptime_widget,
      spacing = dpi(7),
      expand = "none",
      widget = wibox.container.margin,
      layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.fixed.horizontal
  },
  layout = wibox.layout.fixed.horizontal
})

local powermenu = wibox.widget {
  {
    {
      {
        widget = wibox.widget.textbox,
        markup = "",
        font = beautiful.icon_font .. " 20",
      },
      widget = wibox.container.margin,
      margins = 10,
    },
    widget = wibox.container.background,
    shape = gears.shape.circle,
    bg = beautiful.bg1
  },
  widget = wibox.container.margin,
  buttons = {
    awful.button({}, 1, function()
      require 'modules.exit-screen'
      awesome.emit_signal('modules::exit_screen:show')
    end)
  },
}

local lock = wibox.widget {
  {
    {
      {
        widget = wibox.widget.textbox,
        markup = "",
        font = beautiful.icon_font .. " 20",
      },
      widget = wibox.container.margin,
      margins = 10,
    },
    widget = wibox.container.background,
    shape = gears.shape.circle,
    bg = beautiful.bg1
  },
  widget = wibox.container.margin,
  buttons = {
    awful.button({}, 1, function() awful.spawn(lock) end)
  },
}

local userProfile = wibox.widget {
  {
    {
      imguser,
      margins = dpi(10),
      widget = wibox.container.margin
    },
    {
      layout = wibox.layout.fixed.vertical,
      expand = "none",
      helpers.vertical_pad(dpi(15)),
      info,
    },
    {
      lock,
      powermenu,
      spacing = 20,
      layout = wibox.layout.fixed.horizontal,
    },
    layout = wibox.layout.align.horizontal
  },
  bg = beautiful.bg,
  shape = helpers.rrect(10),
  widget = wibox.container.background
}

return userProfile
