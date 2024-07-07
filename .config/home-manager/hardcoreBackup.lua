vim.api.nvim_set_option("termguicolors", true)
vim.opt.winblend = 30
vim.opt.pumblend = 30

-- Custom color scheme
local function set_colorscheme()
  vim.cmd('hi clear')
  vim.o.background = 'dark'

  local colors = {
    bg = "NONE",
    fg = "#c0caf5",
    blue = "#7aa2f7",
    green = "#9ece6a",
    purple = "#bb9af7",
    red = "#f7768e",
    yellow = "#e0af68",
  }

  -- Set up highlight groups
  local highlights = {
    Normal = {fg = colors.fg, bg = colors.bg},
    LineNr = {fg = colors.yellow},
    CursorLine = {bg = "#2c3043"},
    CursorLineNr = {fg = colors.yellow, bold = true},
    Statement = {fg = colors.purple},
    Function = {fg = colors.blue},
    String = {fg = colors.green},
    Constant = {fg = colors.red},
    Comment = {fg = "#565f89", italic = true},
  }

  for group, props in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, props)
  end

  -- Set transparency
  vim.api.nvim_set_hl(0, "Normal", {bg = "NONE", ctermbg = "NONE"})
  vim.api.nvim_set_hl(0, "NormalFloat", {bg = "NONE", ctermbg = "NONE"})
  vim.api.nvim_set_hl(0, "SignColumn", {bg = "NONE", ctermbg = "NONE"})
  vim.api.nvim_set_hl(0, "VertSplit", {bg = "NONE", ctermbg = "NONE"})
end

-- Apply the color scheme
set_colorscheme()
