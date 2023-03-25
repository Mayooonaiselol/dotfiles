local present, cmp = pcall(require, "cmp")

local cmp_kinds = {
  Text = ' ',
  Method = ' ',
  Function = ' ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
}

if not present then
  return
end

opt.completeopt = "menuone,noselect"

cmp.setup {
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<Tab>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Down>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif api.nvim_get_mode().mode == "c" then
        fallback()
      else
        fallback()
      end
    end,
    ["<Up>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif api.nvim_get_mode().mode == "c" then
        fallback()
      else
        fallback()
      end
    end,
  },
  formatting = {
    -- fields = { "kind", "abbr"},
    -- format = function(entry, vim_item)
    --   vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
    --   return vim_item
    -- end,
    fields = { "kind", "abbr" },
    format = function(_, vim_item)
      vim_item.kind = cmp_kinds[vim_item.kind] or ""
      return vim_item
    end,
  },
  sources = {
    { name = "buffer" },
    { name = "path" },
    { name = 'nvim_lsp' },
  },
  window = {
    completion = { border = "solid" },
    documentation = { border = "solid" }
  },
}

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
      { name = 'cmdline' }
    })
})
