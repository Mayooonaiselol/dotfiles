pcall(require, "luarocks.loader")

local awful         = require 'awful'
local naughty       = require 'naughty'
local beautiful = require 'beautiful'
local gears = require 'gears'
local gfs = require 'gears.filesystem'

local log_path = os.getenv("HOME") .. "/Desktop/sysConf/conf/awesome/startup_errors.log"
local log_file = io.open(log_path, "w")

local function log_error(msg)
  if log_file then
    log_file:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. msg .. "\n")
    log_file:flush()
  end
end


if awesome.startup_errors then
    -- naughty.notify {
    --     preset = naughty.config.presets.critical,
    --     title = "Oops, there were errors during startup!",
    --     text = awesome.startup_errors
    -- }
    log_error("AwesomeWM startup error: " .. awesome.startup_errors)
end

beautiful.init(gfs.get_configuration_dir() .. "themes/vanilla.lua")

require 'ui'
require 'signal'
require 'conf'
local helpers = require("helpers")

helpers.enable_rounding()

awful.mouse.snap.edge_enabled = false
awful.mouse.snap.client_enabled = false

-- add --experimental-backends for dccsillag's blur
awful.spawn.with_shell("picom --config /home/mayo/.config/awesome/conf/apps/picom.conf")

collectgarbage('setpause', 110)
collectgarbage('setstepmul', 1000)
