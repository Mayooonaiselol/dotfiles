local M = {}

fn = vim.fn
api = vim.api
cmd = vim.cmd
opt = vim.opt
g = vim.g
autocmd = vim.api.nvim_create_autocmd
opts = { noremap = true, silent = true }
opts_nosilent = { noremap = true }
bufopts = { noremap = true, silent = true, buffer = bufnr }
term_opts = { silent = true }
keymap = vim.api.nvim_set_keymap

_G.theme = "vanilla"

local modules = {
  'core',
  'keys',
  'colors',
  'plug',
  'autocmds'
}

for i, a in ipairs(modules) do
  local ok, err = pcall(require, a)
  if not ok then
    error("Error calling " .. a .. err)
  end
end


function M.setup()
  require("plug.lsp").setup(servers, opts)
end

return M
