local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local ruled     = require('ruled')
local naughty   = require('naughty')
local beautiful = require('beautiful')
local rubato    = require('modules.rubato')

local close_ico = beautiful.icon_x

local helpers = require('helpers')

local notif_pos = "bottom_right"
local notif_size = 50

ruled.notification.connect_signal('request::rules', function()
  -- All notifications will match this rule.
  ruled.notification.append_rule {
    rule       = {},
    properties = {
      screen           = awful.screen.preferred,
      ontop            = true,
      implicit_timeout = 6,
      border_width     = 0,
      position         = notif_pos,
    }
  }
end)

naughty.connect_signal("request::display", function(n)
  -- Animation stolen right off the certified animation lady.
  local x = wibox.widget {
    widget = wibox.widget.imagebox,
    image  = gears.color.recolor_image(close_ico, beautiful.blue),
  }
  local timeout_graph = wibox.widget {
    widget       = wibox.container.arcchart,
    min_value    = 0,
    max_value    = 100,
    value        = 0,
    thickness    = notif_size / 20,
    paddings     = notif_size / 20,
    rounded_edge = true,
    colors       = { beautiful.fg },
    bg           = beautiful.bg4,
    x,
  }
  local title = wibox.widget {
    widget = wibox.widget.textbox,
    font   = beautiful.font,
    text   = n.title
  }
  local summary = wibox.widget {
    widget = wibox.widget.textbox,
    font   = beautiful.font,
    text   = gears.string.xml_unescape(n.message)
  }
  local image = wibox.widget {
    {
      widget        = wibox.widget.imagebox,
      image         = n.image,
      resize        = true,
      halign        = "center",
      valign        = "center",
      clip_shape    = helpers.rrect(5),
      forced_height = notif_size * 2 / 3
    },
    right  = notif_size / 4,
    widget = wibox.container.margin
  }
  naughty.layout.box {
    notification    = n,
    cursor          = "hand2",
    shape           = helpers.rrect(5),
    widget_template = {
      {
        {
          {
            {
              {
                {
                  title,
                  halign = "left",
                  layout = wibox.container.place
                },
                {
                  {
                    timeout_graph,
                    left   = notif_size / 5,
                    bottom = notif_size / 5,
                    top    = notif_size / 5,
                    widget = wibox.container.margin
                  },
                  halign = "right",
                  layout = wibox.container.place
                },
                fill_space = true,
                layout = wibox.layout.align.horizontal
              },
              left   = notif_size / 3,
              right  = notif_size / 3,
              widget = wibox.container.margin
            },
            forced_height = notif_size,
            bg            = beautiful.bg4,
            widget        = wibox.container.background
          },
          strategy = "min",
          width    = notif_size * 4,
          widget   = wibox.container.constraint
        },
        strategy = "max",
        width    = notif_size * 8,
        widget   = wibox.container.constraint
      },
      -- Content config
      {
        {
          {
            {
              image,
              summary,
              layout = wibox.layout.fixed.horizontal
            },
            margins = notif_size / 4,
            widget  = wibox.container.margin
          },
          strategy = "min",
          height   = notif_size * 2,
          widget   = wibox.container.constraint
        },
        strategy = "max",
        width    = notif_size * 8,
        widget   = wibox.container.constraint
      },
      layout = wibox.layout.align.vertical
    },
    id              = "background_role",
    bg              = beautiful.bg,
    border_width    = 1,
    border_color    = beautiful.bg4,
    widget          = naughty.container.background
  }
  local anim = rubato.timed {
    intro      = 0,
    duration   = n.timeout,
    subscribed = function(pos)
      timeout_graph.value = pos
    end
  }
  anim.target = 100
end)
