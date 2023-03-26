local awful = require 'awful'
local hotkeys_popup = require 'awful.hotkeys_popup'
require 'vars'

local function set_keybindings()
  awful.keyboard.append_global_keybindings({

    -- Awesome Keybinds
    awful.key({ mod }, "s", hotkeys_popup.show_help,
      { description = "show help", group = "Awesome" }),
    awful.key({ mod, shift }, "r", awesome.restart,
      { description = "reload awesome", group = "Awesome" }),
    awful.key({ mod }, "x", function()
      for s in screen do
        s.mywibox.visible = not s.mywibox.visible
        if s.mybottomwibox then
          s.mybottomwibox.visible = not s.mybottomwibox.visible
        end
      end
    end,
      { description = "Hide Panel", group = "Awesome" }),
    
    -- System keybinds
    awful.key({ mod }, "l", function() awful.util.spawn(lock) end,
      { description = "lock", group = "System" }),
     awful.key({ mod }, "s", function() awful.spawn(launcher) end,
      { description = "Open run launcher", group = "System" }),
    awful.key({ mod }, "space", function() awesome.emit_signal("toggle::actionCenter") end,
      { description = "Open Action Center", group = "System" }),

    awful.key({}, 'XF86MonBrightnessUp', function() awful.spawn.with_shell('brightnessctl s +5%') end,
      { description = "Increase Brightness", group = "System" }),
    awful.key({}, 'XF86MonBrightnessDown', function() awful.spawn.with_shell('brightnessctl s 5%-') end,
      { description = "Decrease Brightness", group = "System" }),
    awful.key({}, 'XF86AudioRaiseVolume', function() awful.spawn.with_shell('pamixer --increase 2') end,
      { description = "Increase Volume", group = "System" }),
    awful.key({}, 'XF86AudioLowerVolume', function() awful.spawn.with_shell('pamixer --decrease 2') end,
      { description = "Decrease Volume", group = "System" }),
    awful.key({}, 'XF86AudioMute', function() awful.spawn.with_shell('pamixer --toggle-mute') end,
      { description = "Toggle Mute", group = "System" }),

    -- Window management
    awful.key({ alt }, "Tab", function() awful.client.focus.byidx(1) end,
      { description = "Window Switcher", group = "System" }),

    -- Show desktop
    awful.key({ mod }, "d", function(c)
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
    end,
      { description = "Minimize/restore all windows", group = "System" }),

    -- Unknown
    awful.key({ mod }, 'Right', function() awful.tag.incmwfact(0.025) end),
    awful.key({ mod }, 'Left', function() awful.tag.incmwfact(-0.025) end),
    awful.key({ mod }, 'Up', function() awful.client.incwfact(0.05) end),
    awful.key({ mod }, 'Down', function() awful.client.incwfact(-0.05) end),

    -- Screenshots
    awful.key({ mod }, 'Print', function() awful.util.spawn('flameshot gui') end,
      { description = "Take Screenshot", group = "System" }),

    -- Apps
    awful.key({ mod, shift }, "w", function() awful.util.spawn(browser) end,
      { description = "Open browser", group = "Apps" }),
    awful.key({ mod }, "Return", function() awful.spawn(terminal) end,
      { description = "open a terminal", group = "Apps" })
  })

  -- @DOC_NUMBER_KEYBINDINGS@

  awful.keyboard.append_global_keybindings({
    awful.key {
      modifiers   = { mod },
      keygroup    = "numrow",
      description = "only view tag",
      group       = "tag",
      on_press    = function(index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
          tag:view_only()
        end
      end,
    },
    awful.key {
      modifiers   = { mod, ctrl },
      keygroup    = "numrow",
      description = "toggle tag",
      group       = "tag",
      on_press    = function(index)
        local screen = awful.screen.focused()
        local tag = screen.tags[index]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
    },
    awful.key {
      modifiers   = { mod, shift },
      keygroup    = "numrow",
      description = "move focused client to tag",
      group       = "tag",
      on_press    = function(index)
        if client.focus then
          local tag = client.focus.screen.tags[index]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
    },
    awful.key {
      modifiers   = { mod, ctrl, shift },
      keygroup    = "numrow",
      description = "toggle focused client on tag",
      group       = "tag",
      on_press    = function(index)
        if client.focus then
          local tag = client.focus.screen.tags[index]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
    },
    awful.key {
      modifiers   = { mod },
      keygroup    = "numpad",
      description = "select layout directly",
      group       = "layout",
      on_press    = function(index)
        local t = awful.screen.focused().selected_tag
        if t then
          t.layout = t.layouts[index] or t.layout
        end
      end,
    }
  })

  -- @DOC_CLIENT_KEYBINDINGS@
  client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
      awful.key({ mod }, "f",
        function(c)
          c.fullscreen = not c.fullscreen
          c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }),
      awful.key({ mod }, "w", function(c) c:kill() end,
        { description = "close", group = "client" }),
      awful.key({ mod, ctrl }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),
      awful.key({ mod, ctrl }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),
      awful.key({ mod }, "o", function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }),
      awful.key({ mod }, "t", function(c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }),
      awful.key({ mod }, "n",
        function(c)
          -- The client currently has the input focus, so it cannot be
          -- minimized, since minimized clients can't have the focus.
          c.minimized = true
        end,
        { description = "minimize", group = "client" }),
      awful.key({ mod, }, "m",
        function(c)
          c.maximized = not c.maximized
          c:raise()
        end,
        { description = "(un)maximize", group = "client" }),
      awful.key({ mod, ctrl }, "m",
        function(c)
          c.maximized_vertical = not c.maximized_vertical
          c:raise()
        end,
        { description = "(un)maximize vertically", group = "client" }),
      awful.key({ mod, shift }, "m",
        function(c)
          c.maximized_horizontal = not c.maximized_horizontal
          c:raise()
        end,
        { description = "(un)maximize horizontally", group = "client" }),
    })
  end)
end

set_keybindings()
