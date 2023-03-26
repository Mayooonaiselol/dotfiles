-- the notification themselves
local helpers = require("helpers")
local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
return function(icon, notification, width)

  -- table of icons
  -- local icons = {
  --   ["firefox"]  = { icon = "󰈹" },
  --   ["discord"]  = { icon = "󰙯" },
  --   ["dunstify"] = { icon = "󱝁" },
  -- }

  local time = os.date("%H:%M")

  local appicon = ''

  -- if icons[string.lower(notification.app_name)] then
  --   appicon = icons[string.lower(notification.app_name)]
  -- else
  --   appicon = ''
  -- end

  local appiconbox = wibox.widget {
    {
      {
        font   = beautiful.icon_font .. " 16",
        markup = "<span foreground='" .. beautiful.blue .. "'>" .. appicon .. "</span>",
        align  = "center",
        valign = "center",
        widget = wibox.widget.textbox
      },
      widget = wibox.container.margin,
      margins = 4,
    },
    bg = beautiful.bg1 .. "1A",
    widget = wibox.container.background,
  }
  local message = wibox.widget {
    markup = helpers.colorize_text(notification.message, beautiful.fg),
    font = beautiful.font .. " 12",
    align = "left",
    valign = "center",
    widget = wibox.widget.textbox,

  }
  local title = wibox.widget {
    {
      markup = helpers.colorize_text(notification.title .. "  ", beautiful.fg),
      font = beautiful.font .. " 12",
      align = "left",
      valign = "center",
      widget = wibox.widget.textbox,
    },
    layout = wibox.layout.align.horizontal,
  }
  local image_width = 70
  local image_height = 70
  if icon == 'none' then
    image_width = 0
    image_height = 0
  end
  local image = wibox.widget {
    {
      image = icon,
      resize = true,
      halign = "center",
      opacity = 0.6,
      valign = "center",
      widget = wibox.widget.imagebox,
    },
    strategy = "exact",
    height = image_height,
    width = image_width,
    widget = wibox.container.constraint,
  }
  local notifTime = wibox.widget {
    markup = time,
    font = beautiful.font,
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
  }
  local close = wibox.widget {
    markup = helpers.colorize_text("", beautiful.blue),
    font   = beautiful.icon_font .. " 18",
    align  = "center",
    valign = "center",
    widget = wibox.widget.textbox
  }

  local finalnotif = wibox.widget {
    {
      {
        {
          {
            {
              appiconbox,
              title,
              spacing = 10,
              layout = wibox.layout.fixed.horizontal,
            },
            nil,
            {
              notifTime,
              close,
              spacing = 10,
              layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
          },
          margins = 15,
          widget = wibox.container.margin
        },
        bg = beautiful.bg3,
        widget = wibox.container.background
      },
      {
        {
          {
            image,
            message,
            spacing = 30,
            layout = wibox.layout.fixed.horizontal,
          },
          widget = wibox.container.margin,
          margins = 15,
        },
        bg = beautiful.bg3,
        widget = wibox.container.background
      },
      layout = wibox.layout.fixed.vertical,
    },
    shape = helpers.rrect(5),
    widget = wibox.container.background
  }

  close:buttons(gears.table.join(awful.button({}, 1, function()
    _G.notif_center_remove_notif(finalnotif)
  end)))

  return finalnotif
end
