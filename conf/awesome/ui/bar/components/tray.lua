local wibox = require 'wibox'
local awful = require 'awful'
local beautiful = require 'beautiful'
local helpers = require 'helpers'

local dpi = beautiful.xresources.apply_dpi

beautiful.systray_icon_spacing = 10
beautiful.bg_systray = beautiful.bg

-- listens for requests to open/hide the systray popup in the focused screen ofc.
local function get_tray()
    return awful.screen.focused().tray
end

awesome.connect_signal('tray::toggle', function ()
    get_tray().toggle()
end)

awesome.connect_signal('tray::visibility', function (v)
    if v then
        get_tray().show()
    else
        get_tray().hide()
    end
end)

awful.screen.connect_for_each_screen(function (s)
    s.tray = {}

    s.tray.widget = wibox.widget {
        {
            {
                {
                    widget = wibox.widget.systray,
                    horizontal = true,
                    screen = s,
                    base_size = 16,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            margins = dpi(12),
            widget = wibox.container.margin,
        },
        bg = beautiful.bg,
        fg = beautiful.fg,
        widget = wibox.container.background,
        shape = helpers.rrect(5),
    }

    s.tray.popup = awful.popup {
        widget = s.tray.widget,
        screen = s,
        visible = false,
        ontop = true,
        bg = beautiful.bg .. '00',
        fg = beautiful.fg,
        minimum_width = dpi(150),
        minimum_height = dpi(100),
        shape = helpers.rrect(5),
        border_width = 1,
        border_color = beautiful.bg1,
        placement = function (d)
            return awful.placement.bottom_right(d, {
                margins = {
                    right = beautiful.useless_gap * 52,
                    bottom = 60,
                }
            })
        end,
    }

    local self, tray = s.tray.popup, s.tray

    function tray.toggle ()
        if self.visible then
            tray.hide()
        else
            tray.show()
        end
    end

    function tray.show ()
        self.visible = true
    end

    function tray.hide ()
        self.visible = false
    end

    self:connect_signal("mouse::leave", function()
      self.visible = false
    end)
end)
