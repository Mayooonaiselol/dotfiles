local gears = require 'gears'
local beautiful = require 'beautiful'

client.connect_signal("manage", function(c)
    local cairo = require("lgi").cairo
    local default_icon = beautiful.awesome_icon_active
    if c and c.valid and not c.icon then
        local s = gears.surface(default_icon)
        local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
        local cr = cairo.Context(img)
        cr:set_source_surface(s, 0, 0)
        cr:paint()
        c.icon = img._native
    end
end)
