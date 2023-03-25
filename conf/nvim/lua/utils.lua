local M = {}

local fn = vim.fn
local api = vim.api
local cmd = api.nvim_command

function M.notify(options)
  -- if only a string is passed then show a generic notification.
  if type(options) == "string" then
    api.nvim_notify(options, vim.log.levels.INFO, {
      icon = "",
      title = "Notification",
    })
    return
  end

  -- default configuration
  local forced = vim.tbl_extend("force", {
    message = "This is a sample notification.",
    icon = "",
    title = "Notification",
    level = vim.log.levels.INFO,
  }, options or {}) -- don't let the table be nil
  api.nvim_notify(forced.message, forced.level, {
    title = forced.title,
    icon = forced.icon,
  })
end

return M
