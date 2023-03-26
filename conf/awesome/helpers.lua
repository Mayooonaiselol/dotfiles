local gears = require 'gears'
local gshape = require 'gears.shape'
local beautiful = require 'beautiful'
local wibox = require 'wibox'
local dpi = require("beautiful.xresources").apply_dpi

local helpers = {}

function helpers.rrect(radius)
	return function(cr, width, height)
		gshape.rounded_rect(cr, width, height, radius)
	end
end

--- Helper function to be used by decoration themes to enable client rounding
function helpers.enable_rounding()
	--- Apply rounded corners to clients if needed
	if beautiful.border_radius and beautiful.border_radius > 0 then
		client.connect_signal("manage", function(c, startup)
			if not c.fullscreen and not c.maximized then
				c.shape = helpers.rrect(beautiful.border_radius)
			end
		end)

		--- Fullscreen and maximized clients should not have rounded corners
		local function no_round_corners(c)
			if c.fullscreen or c.maximized then
				c.shape = gears.shape.rectangle
			else
				c.shape = helpers.rrect(beautiful.border_radius)
			end
		end

		client.connect_signal("property::fullscreen", no_round_corners)
		client.connect_signal("property::maximized", no_round_corners)

		beautiful.snap_shape = helpers.rrect(beautiful.border_radius * 2)
	else
		beautiful.snap_shape = gears.shape.rectangle
	end
end

function helpers.add_hover_cursor(w, hover_cursor)
  local original_cursor = "left_ptr"

  w:connect_signal("mouse::enter", function()
    local w = _G.mouse.current_wibox
    if w then
      w.cursor = hover_cursor
    end
  end)

  w:connect_signal("mouse::leave", function()
    local w = _G.mouse.current_wibox
    if w then
      w.cursor = original_cursor
    end
  end)
end

function helpers.complex_capitalizing (s)
    local r, i = '', 0
    for w in s:gsub('-', ' '):gmatch('%S+') do
        local cs = helpers.capitalize(w)
        if i == 0 then
            r = cs
        else
            r = r .. ' ' .. cs
        end
        i = i + 1
    end

    return r
end

-- Create partially rounded rect

helpers.prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl,
                                           radius)
    end
end

function helpers.colorize_text(txt, fg)

    if fg == "" then
        fg = "#ffffff"
    end

    return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

function helpers.add_hover(element, bg, hbg)
    element:connect_signal('mouse::enter', function (self)
        self.bg = hbg
    end)
    element:connect_signal('mouse::leave', function (self)
        self.bg = bg
    end)
end

-- create a simple rounded-like button with hover support
function helpers.mkbtn(template, bg, hbg, radius)
    local button = wibox.widget {
        {
            template,
            margins = dpi(4),
            widget  = wibox.container.margin,
        },
        bg     = bg,
        widget = wibox.container.background,
        shape  = helpers.rrect(radius),
    }
    if bg and hbg then
        helpers.add_hover(button, bg, hbg)
    end
    return button
end

function helpers.vertical_pad(height)
    return wibox.widget {
        forced_height = height,
        layout = wibox.layout.fixed.vertical
    }
end

function helpers.horizontal_pad(width)
    return wibox.widget {
        forced_width = width,
        layout = wibox.layout.fixed.horizontal
    }
end

return helpers
