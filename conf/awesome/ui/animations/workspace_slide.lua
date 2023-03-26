local rubato = require("modules.rubato")
local awful = require 'awful'

-- Define the sliding animation function
local function slide_animation(new_screen, direction)
  local current_screen = awful.screen.focused()
  local current_tag = current_screen.selected_tag
  local new_tag = new_screen.selected_tag

  if not current_tag or not new_tag then
    return
  end

  local x1, y1 = current_screen.workarea.x, current_screen.workarea.y
  local x2, y2 = new_screen.workarea.x, new_screen.workarea.y
  local dx = x2 - x1
  local dy = y2 - y1

  local from, to
  if direction == "left" then
    from = { x = 0, y = 0 }
    to = { x = -dx, y = -dy }
  elseif direction == "right" then
    from = { x = 0, y = 0 }
    to = { x = dx, y = dy }
  elseif direction == "up" then
    from = { x = 0, y = 0 }
    to = { x = -dx, y = -dy }
  elseif direction == "down" then
    from = { x = 0, y = 0 }
    to = { x = dx, y = dy }
  else
    return
  end

  local animation = rubato.create_translation_animation(current_tag, {
    from = from,
    to = to,
    easing = rubato.easing.cubic_out,
    duration = 0.3,
  })

  animation:play()
  awful.tag.viewnone(current_screen)
  awful.tag.viewmore(new_tag)
end
