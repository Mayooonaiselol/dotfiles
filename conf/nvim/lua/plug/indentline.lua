local present, indent_blankline = pcall(require, "indent_blankline")

if not present then 
  return
end

indent_blankline.setup {
  filetype_exclude = {
    "help",
    "terminal",
    "dashboard",
    "packer",
    "TelescopePrompt",
    "TelescopeResults",
    "",
  },
  buftype_exclude = { "terminal", "nofile" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
}
