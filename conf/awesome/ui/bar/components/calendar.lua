local awful = require 'awful'
local beautiful = require 'beautiful'
local wibox = require 'wibox'
local gears = require 'gears'
local helpers = require 'helpers'
local dpi = beautiful.xresources.apply_dpi

local getCalendar = function()
  return awful.screen.focused().calendar
end

awesome.connect_signal('calendar::toggle', function()
  getCalendar().toggle()
end)

awful.screen.connect_for_each_screen(function(s)
  s.calendar = {}
  s.calendar.calendar = wibox.widget {
    date = os.date('*t'),
    spacing = dpi(2),
    font = beautiful.font,
    widget = wibox.widget.calendar.month,
    fn_embed = function(widget, flag, date)
      local focus_widget = wibox.widget {
        text = date.day,
        align = 'center',
        widget = wibox.widget.textbox,
      }
      local torender = flag == 'focus' and focus_widget or widget
      if flag == 'header' then
        torender.font = beautiful.font_bold .. " 16"
      end
      local colors = {
        header = beautiful.pink,
        focus = beautiful.yellow,
        weekday = beautiful.blue
      }

      local color = colors[flag] or beautiful.fg
      return wibox.widget {
        {
          {
            torender,
            margins = dpi(7),
            widget = wibox.container.margin,
          },
          bg = flag == 'focus' and beautiful.bg4 or beautiful.bg,
          fg = color,
          widget = wibox.container.background,
          shape = flag == 'focus' and gears.shape.circle or nil,
        },
        widget = wibox.container.margin,
        margins = {
          left = 5,
          right = 5,
        }
      }
    end
  }

  s.calendar.mainbox = wibox.widget {

    {
      widget = s.calendar.calendar
    },
    widget = wibox.container.margin,
    margins = 12
  }

  s.calendar.popup = awful.popup {
    bg = beautiful.bg,
    fg = beautiful.fg,
    visible = false,
    ontop = true,
    placement = function(d)
      return awful.placement.bottom_right(d, { margins = {
        bottom = 60,
        right = 10,
      } })
    end,
    shape = helpers.rrect(10),
    screen = s,
    widget = s.calendar.mainbox,
    border_width = 1,
    border_color = beautiful.bg1
  }

  local self = s.calendar.popup

  function s.calendar.toggle()
    self.visible = not self.visible
  end

  self:connect_signal("mouse::leave", function()
    self.visible = false
  end)
end)
