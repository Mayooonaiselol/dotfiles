local theme = _G.theme

local present, base16 = pcall(require, "base16-colorscheme")
if not present then
  return
end

local present, colors = pcall(require, "colors." .. theme)
if present then
  base16.setup(colors)
else
  cmd("colorscheme base16-" .. theme)
end

-- Highlights
local function hl(highlight, fg, bg)
  if fg == nil then fg = "none" end
  if bg == nil then bg = "none" end
  cmd("hi " .. highlight .. " guifg=" .. fg .. " guibg=" .. bg)
end

local function hlgui(highlight, gui, fg, bg)
  if fg == nil then fg = "none" end
  if bg == nil then bg = "none" end
  cmd("hi " .. highlight .. " gui=" .. gui .. " guifg=" .. fg .. " guibg=" .. bg)
end

-- Status Line
hlgui("StatusLineNC", "underline", colors.base03, nil)
hlgui("StatusLine", "underline", colors.base03, nil)

-- Telescope
hl("TelescopePromptBorder", colors.base01, colors.base01)
hl("TelescopePromptNormal", nil, colors.base01)
hl("TelescopePromptPrefix", colors.base08, colors.base01)
hl("TelescopeSelection", nil, colors.base01)
hl("Normal", nil, nil)

-- Menu
hl("Pmenu", nil, colors.base01)
hl("PmenuSbar", nil, colors.base01)
hl("PmenuSel", colors.base01, colors.base05)
hl("PmenuThumb", nil, colors.base02)

-- CMP
hl("CmpItemAbbrMatch", colors.base05)
hl("CmpItemAbbrMatchFuzzy", colors.base05)
hl("CmpItemAbbr", colors.base03)
hl("CmpItemKind", colors.base0E)
hl("CmpItemMenu", colors.base0E)
hl("CmpItemKindSnippet", colors.base0E)

-- Number
hl("CursorLine")
hl("CursorLineNR")
hl("LineNr", colors.base03)
hl("SignColumn", nil, nil)

-- Others
hl("VertSplit", colors.base01, nil)
hl("NormalFloat", nil, colors.base01)
hl("FloatBorder", colors.base01, colors.base01)
cmd[[hi Keyword gui=italic cterm=italic]]
cmd[[hi Comment gui=italic cterm=italic]]

-- NvimTree
-- hl("NvimTreeNormal", nil, colors.base01 )
