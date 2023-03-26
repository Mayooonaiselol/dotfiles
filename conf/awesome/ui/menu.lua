local beautiful = require("beautiful")
local awful = require("awful")
local helpers = require 'helpers'
local wibox = require 'wibox'
require 'vars'

local menu = {}
-- Create a launcher widget and a main menu
menu.mymenu = awful.menu({ items = {
  { "Power Menu" },
  { "Restart Awesome", awesome.restart, beautiful.icon_awsm_restart },
  { "Open Terminal", terminal, beautiful.icon_terminal },
  { "Open Explorer", explorer, beautiful.icon_explorer }
}
})

-- menu.start = freedesktop.menu.build({
--   after = {
--     { "Open Explorer", explorer, beautiful.icon_explorer },
--     { "Open Terminal", terminal, beautiful.icon_terminal },
--     { "Restart Awesome", awesome.restart, beautiful.icon_awsm_restart },
--     { "Power Menu", function()
--         require 'modules.exit-screen'
--         awesome.emit_signal('modules::exit_screen:show')
--       end
--     }
--   }
-- })

menu.mymenu.wibox.shape = helpers.rrect(5)
menu.mymenu.wibox:set_widget(wibox.widget({
  menu.mymenu.wibox.widget,
  shape = helpers.rrect(5),
  widget = wibox.container.background,
}))

-- menu.start.wibox.shape = helpers.rrect(5)
-- menu.start.wibox:set_widget(wibox.widget({
--   menu.start.wibox.widget,
--   shape = helpers.rrect(5),
--   widget = wibox.container.background,
-- }))

awful.menu.original_new = awful.menu.new

function awful.menu.new(...)
  local ret = awful.menu.original_new(...)

  ret.wibox.shape = helpers.rrect(5)
  ret.wibox:set_widget(wibox.widget {
    ret.wibox.widget,
    widget = wibox.container.background,
    shape = helpers.rrect(5),
  })

  return ret
end

-- menu.start.wibox:connect_signal("mouse::leave", function()
--   if not menu.start.active_child or
--       (menu.start.wibox ~= mouse.current_wibox and
--           menu.start.active_child.wibox ~= mouse.current_wibox) then
--     menu.start:hide()
--   else
--     menu.start.active_child.wibox:connect_signal("mouse::leave",
--       function()
--         if menu.start.wibox ~= mouse.current_wibox then
--           menu.start:hide()
--         end
--       end)
--   end
-- end)

menu.mymenu.wibox:connect_signal("mouse::leave", function()
  if not menu.mymenu.active_child or
      (menu.mymenu.wibox ~= mouse.current_wibox and
          menu.mymenu.active_child.wibox ~= mouse.current_wibox) then
    menu.mymenu:hide()
  else
    menu.mymenu.active_child.wibox:connect_signal("mouse::leave",
      function()
        if menu.mymenu.wibox ~= mouse.current_wibox then
          menu.mymenu:hide()
        end
      end)
  end
end)

return menu
