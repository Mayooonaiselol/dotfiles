local dpi          = require("beautiful.xresources").apply_dpi
local theme_assets = require("beautiful.theme_assets")
local gears        = require("gears")
local gfs          = require("gears.filesystem")
local helpers      = require 'helpers'

local assets_path = gfs.get_configuration_dir() .. "assets/"
local titlebar_assets_path = assets_path .. "titlebar/"
local icons_assets_path = assets_path .. "icons/"
local themes_path = gfs.get_themes_dir()
local theme = {}

local os = os

-- wallpaper
theme.wpdir     = os.getenv("HOME") .. "/Desktop/wallpapers"
theme.wallpaper = theme.wpdir .. "/wallhaven-j3j5vm.jpg"

-- profile picture
theme.profile = gfs.get_configuration_dir() .. "assets/profile/profile2.jpeg"

-- Fonts
theme.font      = "Roboto"
theme.font_bold = "Roboto Bold"
theme.nerd_font = "Jetbrains Mono Nerd Font"
theme.icon_font = "Material Icons"

-- Colors
theme.pink         = "#fa92c8"
theme.light_pink   = "#fab4d8"
theme.purple       = "#ce71fa"
theme.light_purple = "#dc9efa"
theme.blue         = "#68a7dd"
theme.light_blue   = "#96bcdd"
theme.grey         = "#424a58"
theme.light_grey   = "#5f6d7c"
theme.yellow       = "#d3c356"
theme.green        = "#78a05f"
theme.light_green  = "#9fb293"

theme.transparent = "#00000000"

theme.bg  = "#1a2025"
theme.bg1 = "#323d47" -- light_grey_focus
theme.bg2 = "#afb7c0b3" -- bg_focus_thin
theme.bg3 = "#424a5880" -- grey focus
theme.bg4 = "#29333b" -- bg_focus
theme.bg5 = "#1a2025b3" -- old_bg_focus
theme.bg6 = "#4b5c7b40"
theme.bg7 = "#424a58"

theme.menu_bg_normal = "#1a202580"
theme.menu_bg_focus  = theme.bg1


theme.fg          = "#e5e8e6"
theme.fg_urgent   = "#be868c"
theme.fg_minimize = "#afb7c0"

-- titlebar
theme.titlebar_bg_focus = "#282e36"
theme.titlebar_bg_normal = theme.bg

theme.border_width  = dpi(1)
theme.border_normal = "#1c2022"
theme.border_focus  = "#282e36"
theme.border_marked = "#3ca4d8"
theme.border_radius = 10

theme.bar_element_radius = 0

theme.notification_margin = 15
theme.notification_width = dpi(300)

theme.menu_border_width = 0
theme.menu_width        = dpi(180)
theme.menu_height       = dpi(35)

theme.menu_font = theme.font .. " 10"

theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil
theme.taglist_squares_sel_empty = nil
theme.taglist_squares_unsel_empty = nil

theme.useless_gap = 5

-- taglist
theme.taglist_bg = theme.transparent
theme.taglist_fg_empty = theme.light_grey
theme.taglist_fg = theme.fg
theme.taglist_fg_occupied = theme.blue
theme.taglist_bg_focus = theme.transparent

-- layouts
theme.layout_floating   = gears.color.recolor_image(themes_path .. "default/layouts/floatingw.png", theme.fg)
theme.layout_fullscreen = gears.color.recolor_image(themes_path .. "default/layouts/fullscreenw.png", theme.fg)
theme.layout_tile       = gears.color.recolor_image(themes_path .. "default/layouts/tilew.png", theme.fg)
theme.layout_max        = gears.color.recolor_image(themes_path .. "default/layouts/maxw.png", theme.fg)

-- tasklist
theme.tasklist_plain_task_name = true
theme.tasklist_bg_focus = theme.bg1
theme.tasklist_bg_normal = theme.transparent

-- task preview
theme.task_preview_widget_border_radius = 5
theme.task_preview_widget_bg = theme.bg4
theme.task_preview_widget_border_color = theme.bg2
theme.task_preview_widget_border_width = 1
theme.task_preview_widget_margin = 10

-- titlebar
theme.titlebar_close_button_normal = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.grey)
theme.titlebar_close_button_focus = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.grey)
theme.titlebar_close_button_focus_hover = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.pink)
theme.titlebar_close_button_focus_press = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.light_pink)

theme.titlebar_maximized_button_normal_inactive = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.grey)
theme.titlebar_maximized_button_focus_inactive = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.grey)
theme.titlebar_maximized_button_focus_inactive_hover = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.purple)
theme.titlebar_maximized_button_focus_inactive_press = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.light_purple)

theme.titlebar_maximized_button_normal_active = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.grey)
theme.titlebar_maximized_button_focus_active = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.grey)
theme.titlebar_maximized_button_focus_active_hover = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.purple)
theme.titlebar_maximized_button_focus_active_press = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.light_purple)

theme.titlebar_minimize_button_normal = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.grey)
theme.titlebar_minimize_button_focus = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.grey)
theme.titlebar_minimize_button_focus_hover = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.blue)
theme.titlebar_minimize_button_focus_press = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.light_blue)

theme.titlebar_ontop_button_normal_inactive = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.grey)
theme.titlebar_ontop_button_focus_inactive = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.grey)
theme.titlebar_ontop_button_focus_inactive_hover = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.green)
theme.titlebar_ontop_button_focus_inactive_press = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.light_green)
theme.titlebar_ontop_button_normal_active = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.green)
theme.titlebar_ontop_button_focus_active = gears.color.recolor_image(titlebar_assets_path .. "circle.png", theme.green)
theme.titlebar_ontop_button_focus_active_hover = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.green)
theme.titlebar_ontop_button_focus_active_press = gears.color.recolor_image(titlebar_assets_path .. "circle.png",
  theme.light_green)

-- icons
theme.icon_menu = gears.color.recolor_image(icons_assets_path .. "menu.svg", theme.fg)
theme.icon_submenu = gears.color.recolor_image(icons_assets_path .. "chevron-right.png", theme.fg)
theme.icon_poweroff = gears.color.recolor_image(icons_assets_path .. "power.svg", theme.fg)
theme.icon_terminal = gears.color.recolor_image(icons_assets_path .. "terminal.png", theme.fg)
theme.icon_awsm_restart = gears.color.recolor_image(icons_assets_path .. "rotate-cw.png", theme.fg)
theme.icon_explorer = gears.color.recolor_image(icons_assets_path .. "folder.png", theme.fg)
theme.icon_x = gears.color.recolor_image(icons_assets_path .. "x.svg", theme.fg)

-- awesome_icon
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height, theme.fg, theme.bg
)

theme.awesome_icon_active = theme_assets.awesome_icon(
  theme.menu_height, theme.blue, theme.bg1
)

theme.menu_submenu_icon = theme.icon_submenu

theme.icon_theme = "Colloid-dark"

-- tooltip
theme.tooltip_bg = theme.bg4
theme.tooltip_fg = theme.fg
theme.tooltip_shape = helpers.rrect(5)
theme.tooltip_font = theme.font

return theme
