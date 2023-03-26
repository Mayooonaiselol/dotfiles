local awful         = require("awful")
local gears         = require("gears")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local dpi           = beautiful.xresources.apply_dpi
local helpers       = require("helpers")
require 'vars'

local button_size = dpi(110)

local icons = {
    poweroff  = "",
    suspend   = "",
    reboot    = "",
    exit      = "﫼",
    lock      = "",
    hibernate = ""
}

-- Commands
local poweroff_command = function()
	awful.spawn.with_shell("systemctl poweroff")
	awesome.emit_signal('modules::exit_screen:hide')
end

local reboot_command = function()
	awful.spawn.with_shell("systemctl reboot")
	awesome.emit_signal('modules::exit_screen:hide')
end

local suspend_command = function()
	awesome.emit_signal('modules::exit_screen:hide')
    awful.spawn.with_shell("systemctl suspend")
end

local exit_command = function() awesome.quit() end

local lock_command = function() awful.spawn(lock) end

local hibernate_command = function()
  awesome.emit_signal('modules::exit_screen:hide')
  awful.spawn(lock)
  awful.spawn.with_shell("systemctl hibernate")
end

-- helper function for buttons
local cr_btn = function (text_cc, icon_cc, color, command)
    local i = wibox.widget{
        align = "center",
        valign = "center",
        font = beautiful.icon_font .. " " .. "30",
        markup = helpers.colorize_text(icon_cc, beautiful.fg),
        widget = wibox.widget.textbox()
    }

    local text = wibox.widget{
        align = "center",
        valign = "center",
        font = beautiful.font,
        markup = helpers.colorize_text(text_cc, beautiful.fg),
        widget = wibox.widget.textbox()
    }

    local button = wibox.widget {
        {
            nil,
            i,
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
        forced_height   = button_size,
        forced_width    = button_size,
        shape           = gears.shape.circle,
		border_color	= "#00000000",
		border_width	= dpi(3),
        bg              = beautiful.bg5,
        widget          = wibox.container.background
    }

	local mainbox_button = wibox.widget{
		button,
		text,
		layout = wibox.layout.fixed.vertical,
		spacing = dpi(12)
	}

    button:buttons(gears.table.join( awful.button({}, 1, function() command() end)))

    button:connect_signal("mouse::enter", function()
        i.markup = helpers.colorize_text(icon_cc, beautiful.blue)
        text.markup = helpers.colorize_text(text_cc, beautiful.blue)
        button.border_color = beautiful.blue
    end)
    button:connect_signal("mouse::leave", function()
        i.markup = helpers.colorize_text(icon_cc, beautiful.fg)
        text.markup = helpers.colorize_text(text_cc, beautiful.fg)
        button.border_color = beautiful.bg5
    end)

    helpers.add_hover_cursor(button, "hand2")
    helpers.add_hover(button, beautiful.bg5, beautiful.grey_focus)

    return mainbox_button
end


-- Widgets themselves
-- ~~~~~~~~~~~~~~~~~~

-- Create the buttons
local poweroff  = cr_btn("Power off", icons.poweroff, beautiful.blue, poweroff_command)
local reboot    = cr_btn("Restart", icons.reboot,   beautiful.blue, reboot_command)
local suspend   = cr_btn("Sleep", icons.suspend,  beautiful.blue, suspend_command)
local exit      = cr_btn("Log out", icons.exit,     beautiful.blue, exit_command)
local lock      = cr_btn("Lock", icons.lock, beautiful.blue, lock_command)
local hibernate = cr_btn("Hibernate", icons.hibernate, beautiful.blue, hibernate_command)

-- exit screen
local exit_screen_f = function(s)
	s.exit_screen = wibox{
		screen 	= s,
		type 	= 'splash',
		visible = false,
		ontop 	= true,
		bg 		= beautiful.grey .. "80",
		fg 		= beautiful.fg,
		height 	= s.geometry.height,
		width 	= s.geometry.width,
		x 		= s.geometry.x,
		y 		= s.geometry.y
	}

    s.exit_screen:buttons(gears.table.join(awful.button(
				{}, 2, function()
					awesome.emit_signal('modules::exit_screen:hide')
				end),

			awful.button(
				{}, 3, function()
					awesome.emit_signal('modules::exit_screen:hide')
				end
			),

			awful.button(
				{}, 1, function()
					awesome.emit_signal('modules::exit_screen:hide')
				end
			)
		)
	)

    s.exit_screen:setup {
		nil,
		{
			nil,
			nil,
			{
				{
					{
						{
              lock,
							suspend,
							exit,
							poweroff,
							reboot,
              hibernate,
							spacing = dpi(45),
							layout = wibox.layout.fixed.horizontal
						},
						layout = wibox.layout.fixed.horizontal,
						spacing = dpi(45)
					},
					widget = wibox.container.margin,
					margins = dpi(35)
				},
				widget = wibox.container.background,
				bg = beautiful.bg5,
				shape = helpers.prrect(5, true, true, false, false)
			},
			layout = wibox.layout.align.vertical,
			expand = "none"
		},
		expand = "none",
		layout = wibox.layout.align.horizontal
	}

end


screen.connect_signal('request::desktop_decoration',
	function(s)
		exit_screen_f(s)
	end
)

screen.connect_signal('removed',
	function(s)
		exit_screen_f(s)
	end
)

local exit_screen_grabber = awful.keygrabber {
	auto_start = true,
	stop_event = 'release',
	keypressed_callback = function(self, mod, key, command)
		if key == 's' then
			suspend_command()

		elseif key == 'e' then
			exit_command()

		elseif key == 'p' then
			poweroff_command()

		elseif key == 'r' then
			reboot_command()

		elseif key == 'Escape' or key == 'q' or key == 'v' then
			awesome.emit_signal('modules::exit_screen:hide')
		end
	end
}

awesome.connect_signal(
	'modules::exit_screen:show',
	function()
		for s in screen do
			s.exit_screen.visible = false
		end
		awful.screen.focused().exit_screen.visible = true
		exit_screen_grabber:start()
	end
)

awesome.connect_signal(
	'modules::exit_screen:hide',
	function()
		exit_screen_grabber:stop()
		for s in screen do
			s.exit_screen.visible = false
		end
	end
)
