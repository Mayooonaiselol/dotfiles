local lspinstaller = require'nvim-lsp-installer'
local lspconfig = require'lspconfig'

local nv = require("utils")

local servers = {
	"bashls",
	"pyright",
	"tsserver",
  "html",
  "tailwindcss",
}

for _, name in pairs(servers) do
	local server_is_found, server = lspinstaller.get_server(name)
	if server_is_found then
		if not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end

lspinstaller.setup{}

local capabilities = vim.lsp.protocol.make_client_capabilities()

for _, server in ipairs(lspinstaller.get_installed_servers()) do
  lspconfig[server.name].setup{
    on_attach = function()
      keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      keymap('n', 'K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
      keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
      keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
      keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
      keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
 
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local opt = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opt)
        end
      })
    end,

    flags = {
      debounce_text_changes = 150,
    },

    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  }
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = { source = "always" },
  }
)
