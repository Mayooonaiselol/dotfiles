local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local dpi   = require("beautiful.xresources").apply_dpi

awful.titlebar.enable_tooltip = false

function double_click_event_handler(double_click_event)
    if double_click_timer then
        double_click_timer:stop()
        double_click_timer = nil
        return true
    end
  
    double_click_timer = gears.timer.start_new(0.20, function()
        double_click_timer = nil
        return false
    end)
end

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Default
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            if double_click_event_handler() then
					    c.maximized = not c.maximized
              c:raise()
            else
              if c.maximized == true then
                c.maximized = not c.maximized
              end
              awful.mouse.client.move(c)
	          end
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {
      size = 35,
      position = "top",
    }) : setup {
        { -- Left
            {
                left = dpi(2),
                widget = wibox.container.margin,
            },
            {
                awful.titlebar.widget.iconwidget(c),
                margins = 4,
                widget = wibox.container.margin,
            },
            {
                awful.titlebar.widget.ontopbutton(c),
                margins = 11,
                widget = wibox.container.margin,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            {
                awful.titlebar.widget.minimizebutton(c),
                margins = 9,
                widget = wibox.container.margin,
            },
            {
                awful.titlebar.widget.maximizedbutton(c),
                margins = 9,
                widget = wibox.container.margin,
            },
            {
                awful.titlebar.widget.closebutton(c),
                margins = 9,
                widget = wibox.container.margin,
            },
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
    if c.maximized then
        c.height = c.height - 35
    end
end)
