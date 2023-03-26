local awful     = require 'awful'
local gears     = require 'gears'
local wibox     = require 'wibox'
local beautiful = require 'beautiful'
local helpers   = require 'helpers'
local dpi       = require("beautiful.xresources").apply_dpi

require 'vars'
require 'ui.bar.components.tray'
require 'ui.bar.components.sound'
require 'ui.bar.components.calendar'

-- Status icons
local function status_widget(button)
  return wibox.widget {
    font    = beautiful.icon_font .. " " .. 16,
    align   = "center",
    widget  = wibox.widget.textbox,
    buttons = {
      awful.button({}, 1, button)
    }
  }
end

-- Battery bar
local battery = wibox.widget {
  max_value        = 100,
  forced_width     = 60,
  clip             = true,
  horizontal       = true,
  shape            = helpers.rrect(5),
  bar_shape        = helpers.rrect(5),
  background_color = beautiful.bg1,
  color            = beautiful.green,
  widget           = wibox.widget.progressbar
}

local battery_text = status_widget()

local search = wibox.widget {
  {
    {
      {
        font = beautiful.icon_font .. " " .. 18,
        align = "center",
        markup = "",
        widget = wibox.widget.textbox,
      },
      margins = dpi(2),
      widget = wibox.container.margin
    },
    align  = "center",
    widget = wibox.container.place
  },
  bg      = beautiful.bg,
  widget  = wibox.container.background,
  shape   = helpers.rrect(5),
  buttons = {
    awful.button({}, 1, function()
      awful.spawn(launcher)
    end)
  },
}

local systray = wibox.widget {
  {
    text   = "",
    font   = beautiful.icon_font .. " " .. 18,
    align  = "center",
    widget = wibox.widget.textbox,
  },
  bg      = beautiful.bg,
  shape   = helpers.rrect(5),
  widget  = wibox.container.background,
  buttons = {
    awful.button({}, 1, function()
      awesome.emit_signal('tray::toggle')
    end)
  },
}

helpers.add_hover_cursor(systray, "hand2")
helpers.add_hover(systray, beautiful.bg, beautiful.bg1)

local mystart = wibox.widget {
  {
    {
      {
        id         = 'awsm_icon',
        image      = beautiful.awesome_icon,
        clip_shape = helpers.rrect(5),
        widget     = wibox.widget.imagebox,
      },
      margins = dpi(5),
      widget  = wibox.container.margin
    },
    align  = "center",
    widget = wibox.container.place
  },
  bg            = beautiful.bg,
  shape         = helpers.rrect(5),
  forced_height = dpi(50),
  forced_width  = dpi(35),
  widget        = wibox.container.background,
  buttons       = {
    awful.button({}, 1, function() awesome.emit_signal("toggle::actionCenter") end),
  },
}

mystart:connect_signal('mouse::enter', function(self)
  self.bg = beautiful.bg1
  self:get_children_by_id('awsm_icon')[1].image = beautiful.awesome_icon_active
end)

mystart:connect_signal('mouse::leave', function(self)
  self.bg = beautiful.bg
  self:get_children_by_id('awsm_icon')[1].image = beautiful.awesome_icon
end)


helpers.add_hover_cursor(mystart, "hand2")

local time = wibox.widget {
  widget = wibox.container.background,
  buttons = {
    awful.button({}, 1, function()
      awesome.emit_signal('calendar::toggle')
    end),
  },
  {
    widget = wibox.container.margin,
    margins = 10,
    {
      widget = wibox.widget.textclock "%H:%M",
      align = "center",
    },
  },
}

helpers.add_hover_cursor(time, "hand2")

local showdesktop = wibox.widget {
  {
    text = "  ",
    widget = wibox.widget.textbox,
  },
  widget = wibox.container.background,
  bg = beautiful.bg,
  buttons = {
    awful.button({}, 1, function(c)
      if show_desktop then
        for _, c in ipairs(client.get()) do
          c:emit_signal(
            "request::activate", "key.unminimize", { raise = true }
          )
        end
        show_desktop = false
      else
        for _, c in ipairs(client.get()) do
          c.minimized = true
        end
        show_desktop = true
      end
    end)
  },
}

helpers.add_hover(showdesktop, beautiful.bg, beautiful.bg1)

local network = status_widget()
local sound = status_widget(function() awesome.emit_signal('sound::toggle') end)

awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = gears.table.join(
    -- just enables click in tags and scroll
      awful.button({}, 1, function(t)
        t:view_only()
      end),
      awful.button({}, 4, function(t)
        awful.tag.viewprev(t.screen)
      end),
      awful.button({}, 5, function(t)
        awful.tag.viewnext(t.screen)
      end)
    ),
    widget_template = {
      {
        {
          id = "text_role",
          widget = wibox.widget.textbox,
          align = "center",
          valign = "center",
        },
        left = 8,
        right = 8,
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    }
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen          = s,
    filter          = awful.widget.tasklist.filter.currenttags,
    buttons         = gears.table.join(
      awful.button({}, 1, function(c)
        if c == client.focus then
          c.minimized = true
        else
          c:emit_signal("request::activate", "tasklist", { raise = true })
        end
      end),
      awful.button({}, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
      awful.button({}, 4, function() awful.client.focus.byidx(-1) end),
      awful.button({}, 5, function() awful.client.focus.byidx(1) end)
    ),
    layout          = {
      spacing = 5,
      forced_num_cols = 1,
      layout = wibox.layout.grid.horizontal,
    },
    style           = {
      shape = helpers.rrect(4)
    },
    widget_template = {
      {
        {
          id = 'clienticon',
          forced_width = dpi(30),
          forced_height = dpi(30),
          widget = awful.widget.clienticon,
        },
        margins = dpi(3),
        widget = wibox.container.margin,
      },
      id = 'background_role',
      widget = wibox.container.background,
      create_callback = function(self, c, index, objects)
        self:connect_signal('mouse::enter', function()
          awesome.emit_signal('bling::task_preview::visibility', s, true, c)
        end)
        self:connect_signal('mouse::leave', function()
          awesome.emit_signal('bling::task_preview::visibility', s, false, c)
        end)
      end
    },
  }

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "bottom",
    ontop = true,
    height = dpi(50),
    screen = s,
    bg = beautiful.bg,
    fg = beautiful.fg,
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      {
        mystart,
        margins = 8,
        widget = wibox.container.margin,
      },
      {
        search,
        left = dpi(3),
        right = dpi(3),
        top = dpi(12),
        bottom = dpi(12),
        widget = wibox.container.margin,
      },
      {
        s.mytaglist,
        margins = 10,
        widget = wibox.container.margin,
      },
      s.mypromptbox,
    },
    { -- Center widgets
      s.mytasklist,
      widget = wibox.container.margin,
      layout = wibox.container.place
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      {
        margins = 8,
        widget = wibox.container.margin,
      },
      {
        systray,
        margins = 12,
        widget = wibox.container.margin,
      },
      {
        {
          battery,
          {
            battery_text,
            fg     = beautiful.bg,
            widget = wibox.container.background,
          },
          visible = true,
          layout = wibox.layout.stack,
        },
        margins = 12,
        widget = wibox.container.margin,
      },
      {
        network,
        margins = 10,
        widget = wibox.container.margin,
      },
      {
        sound,
        margins = 10,
        widget = wibox.container.margin,
      },
      {
        time,
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin,
      },
      {
        s.mylayoutbox,
        margins = 12,
        widget = wibox.container.margin,
      },
      {
        showdesktop,
        left = 5,
        widget = wibox.container.margin,
      }
    },
  }
end)

-- Battery signal
awesome.connect_signal("signal::battery", function(level, state)
  battery.value = level
  if state == "Charging\n" then
    battery_text.text = ""
    battery_text.font = beautiful.icon_font
  else
    battery_text.text = level .. "%"
    battery_text.font = beautiful.font_bold
  end
end)

-- Network
awesome.connect_signal("signal::network", function(is_enabled)
  network.text = is_enabled and "" or ""
  network.font = beautiful.icon_font .. " 18"
end)

-- Sound
awesome.connect_signal("signal::volume", function(volume, muted)
  sound.text    = muted and "" or ""
  sound.visible = true
  sound.font    = beautiful.icon_font .. " 20"
end)
