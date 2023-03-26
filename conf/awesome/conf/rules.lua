local ruled = require "ruled"
local awful = require "awful"

local function setup_rules ()
    ruled.client.connect_signal("request::rules", function()
        ruled.client.append_rule {
            id         = "global",
            rule       = { },
            properties = {
                focus     = awful.client.focus.filter,
                raise     = true,
                screen    = awful.screen.preferred,
                placement = awful.placement.no_overlap+awful.placement.no_offscreen+awful.placement.centered,
            },
        }
        ruled.client.append_rule {
            id       = "floating",
            rule_any = {
                instance = { "copyq", "pinentry" },
                class    = {
                    "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                    "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
                },
                name    = {
                    "Event Tester",  -- xev.
                },
                role    = {
                    "AlarmWindow",    -- Thunderbird's calendar.
                    "ConfigManager",  -- Thunderbird's about:config.
                    "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
                }
            },
            properties = { floating = true }
        }
        ruled.client.append_rule {
            id         = "titlebars",
            rule_any   = { type = { "normal", "dialog" } },
            properties = { titlebars_enabled = true }
        }
        ruled.client.append_rule {
            id         = "titlebars_2",
            rule_any = {
              class      = { "holiday-hype" }
            },
            properties = { titlebars_enabled = false }
        }
    end)
end

setup_rules()
