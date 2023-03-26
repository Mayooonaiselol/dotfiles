local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local dpi = require 'beautiful.xresources'.apply_dpi
local helpers = require 'helpers'

local userProfile = require 'ui.widgets.userProfile'
local settings = require 'ui.widgets.settings'

local x_length = 500
local y_length = 800

awful.screen.connect_for_each_screen(function(s)
  local actionCenter = wibox({
    type = "dock",
    shape = helpers.rrect(5),
    screen = s,
    width = dpi(x_length),
    height = dpi(y_length),
    bg = beautiful.bg,
    ontop = true,
    visible = false,
    x = beautiful.useless_gap * 2,
    y = 215,
    border_width = 1,
    border_color = beautiful.bg1
  })

  actionCenter:setup {
    {
      userProfile,
      {
        {
          settings,
          spacing = dpi(20),
          layout = wibox.layout.fixed.vertical,
        },
        left = dpi(10),
        right = dpi(10),
        bottom = dpi(10),
        widget = wibox.container.margin,
      },
      spacing = dpi(20),
      layout = wibox.layout.fixed.vertical,
    },
    margins = dpi(15),
    widget = wibox.container.margin,
  }

  awesome.connect_signal("toggle::actionCenter", function()
    actionCenter.visible = not actionCenter.visible
  end)
end)
