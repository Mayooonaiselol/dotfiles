local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local wibox = require("wibox")

return wibox.widget {
  {
    widget = wibox.widget.textbox,
    markup = helpers.colorize_text("Nothing here except the void.", beautiful.fg .. "4D"),
    font = beautiful.font .. " 14",
    valign = "center",
    align = "center"
  },
  margins = { top = dpi(15) },
  widget = wibox.container.margin
}
