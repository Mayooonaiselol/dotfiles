local wibox     = require("wibox")
local awful     = require("awful")
local beautiful = require("beautiful")
local dpi       = require("beautiful").xresources.apply_dpi
local helpers   = require("helpers")
local naughty   = require("naughty")
local gears     = require("gears")
local empty     = require("ui.widgets.notifCenter.void")
local create    = require("ui.widgets.notifCenter.mknotif")

local clearButton = wibox.widget {
  {
    {
      font = beautiful.icon_font .. " 20",
      markup = "",
      widget = wibox.widget.textbox,
      valign = "center",
      align = "center",
    },
    margins = dpi(6),
    widget = wibox.container.margin
  },
  bg = beautiful.bg .. '11',
  widget = wibox.container.background,

}
local title = wibox.widget
{
  font = beautiful.font .. " 14",
  markup = "Notification Center (0)",
  widget = wibox.widget.textbox,
  valign = "center",
  align = "center"
}
local header = wibox.widget {
  title,
  nil,
  clearButton,
  layout = wibox.layout.align.horizontal,
}
local finalcontent = wibox.widget {
  spacing = 20,
  layout = wibox.layout.fixed.vertical,
}
local remove_notifs_empty = true

notif_center_reset_notifs_container = function()
  finalcontent:reset(finalcontent)
  finalcontent:insert(1, empty)
  remove_notifs_empty = true
  title.markup = 'Notification Center (0)'
end

notif_center_remove_notif = function(box)
  finalcontent:remove_widgets(box)

  if #finalcontent.children == 0 then
    finalcontent:insert(1, empty)
    title.markup = 'Notification Center (0)'
    remove_notifs_empty = true
  else
    title.markup = 'Notification Center (' .. #finalcontent.children .. ')'
  end
end

finalcontent:buttons(gears.table.join(
  awful.button({}, 4, nil, function()
    if #finalcontent.children == 1 then
      return
    end
    finalcontent:insert(1, finalcontent.children[#finalcontent.children])
    finalcontent:remove(#finalcontent.children)
  end),

  awful.button({}, 5, nil, function()
    if #finalcontent.children == 1 then
      return
    end
    finalcontent:insert(#finalcontent.children + 1, finalcontent.children[1])
    finalcontent:remove(1)
  end)
))

finalcontent:insert(1, empty)
naughty.connect_signal("request::display", function(n)
  if #finalcontent.children == 1 and remove_notifs_empty then
    finalcontent:reset(finalcontent)
    remove_notifs_empty = false
  end

  local appicon = n.icon or n.app_icon
  if not appicon then
    appicon = 'none'
  end
  title.markup = 'Notification Center (' .. #finalcontent.children + 1 .. ')'
  finalcontent:insert(1, create(appicon, n))
end)
local finalwidget = wibox.widget {
  {
    {
      header,
      finalcontent,
      spacing = dpi(20),
      layout = wibox.layout.fixed.vertical,
    },
    margins = dpi(20),
    widget = wibox.container.margin
  },
  bg = beautiful.bg4 .. 'cc',
  forced_height = dpi(480),
  shape = helpers.rrect(10),
  widget = wibox.container.background,
}

clearButton:buttons(gears.table.join(awful.button({}, 1, function()
  notif_center_reset_notifs_container()
end)))
return finalwidget

