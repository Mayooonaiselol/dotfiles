local present, telescope = pcall(require, "telescope")

if not present then
  return
end

telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.otf",
      "%.ttf",
      "node_modules",
      ".git",
    },
    prompt_prefix = "  ",
    selection_caret = " ",
    entry_prefix = "  ",
    sorting_srategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        results_width = 0.8,
        preview_width = 0.55,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.8,
      preview_cutoff = 120,
    },
    use_less = true,
    set_env = {
      COLORTERM = "truecolor",
    },
    dynamic_preview_title = true,
    border = {},
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
}
