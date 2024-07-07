vim.api.nvim_set_option("termguicolors", true)
vim.opt.winblend = 30
vim.opt.pumblend = 30

-- Custom color scheme based on Hardcore colors with variable transparency
local function set_colorscheme()
  vim.cmd('hi clear')
  vim.o.background = 'dark'

  -- Set transparency level (0.0 to 1.0, where 1.0 is fully opaque)
  local transparency = 0.8

  local function blend(color, alpha)
    local r, g, b = color:match("#(%x%x)(%x%x)(%x%x)")
    r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
    local blend_channel = function(c)
      return math.floor(c * alpha + 255 * (1 - alpha))
    end
    return string.format("#%02x%02x%02x", blend_channel(r), blend_channel(g), blend_channel(b))
  end

  local colors = {
    bg = blend("#151326", transparency),
    fg = "#EA549F",
    black = "#000000",
    bright_black = blend("#1A172E", transparency),
    red = "#E92888",
    bright_red = "#EB2A88",
    green = "#4EC9B0",
    bright_green = "#1AD69C",
    yellow = "#FFCB00",
    bright_yellow = "#FFDB37",
    blue = "#579BD5",
    bright_blue = "#9CDCFE",
    purple = "#714896",
    bright_purple = "#975EAB",
    cyan = "#00B6D6",
    bright_cyan = "#2BC4E2",
    white = "#FFFFFF",
    bright_white = "#E8C7ED",
    cursor = "#FFFFFF",
    selection = blend("#FFFFFF", 0.3),
  }

  -- Set up highlight groups
  local highlights = {
    Normal = {fg = colors.fg, bg = colors.bg},
    LineNr = {fg = colors.bright_black},
    CursorLine = {bg = colors.bright_black},
    CursorLineNr = {fg = colors.bright_yellow, bold = true},
    Statement = {fg = colors.red},
    Function = {fg = colors.blue},
    String = {fg = colors.green},
    Constant = {fg = colors.bright_purple},
    Comment = {fg = colors.bright_black, italic = true},
    Special = {fg = colors.yellow},
    Identifier = {fg = colors.cyan},
    PreProc = {fg = colors.bright_blue},
    Type = {fg = colors.bright_green},
    Visual = {bg = colors.selection},
    Search = {fg = colors.bg, bg = colors.bright_yellow},
    IncSearch = {fg = colors.bg, bg = colors.yellow},
    Folded = {fg = colors.bright_black, bg = blend(colors.black, transparency)},
    StatusLine = {fg = colors.fg, bg = colors.bright_black},
    VertSplit = {fg = colors.bright_black, bg = colors.bg},
    PmenuSel = {fg = colors.bg, bg = colors.bright_cyan},
    Pmenu = {fg = colors.fg, bg = blend(colors.black, transparency)},
    MatchParen = {fg = colors.bright_yellow, bold = true},
    Todo = {fg = colors.bright_yellow, bold = true},
    Error = {fg = colors.bright_red, bold = true},
    WarningMsg = {fg = colors.yellow, bold = true},
    Keyword = {fg = colors.red},
    Title = {fg = colors.bright_blue, bold = true},
    Cursor = {fg = colors.bg, bg = colors.cursor},
    ColorColumn = {bg = colors.bright_black},
    SignColumn = {bg = colors.bg},
    NonText = {fg = colors.bright_black},
    SpecialKey = {fg = colors.bright_black},
    Directory = {fg = colors.blue},
  }

  for group, props in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, props)
  end

  -- Set transparency for specific elements
  vim.api.nvim_set_hl(0, "Normal", {fg = colors.fg, bg = "NONE"})
  vim.api.nvim_set_hl(0, "NormalFloat", {bg = "NONE"})
  vim.api.nvim_set_hl(0, "SignColumn", {bg = "NONE"})
  vim.api.nvim_set_hl(0, "VertSplit", {fg = colors.bright_black, bg = "NONE"})
end

-- Apply the color scheme
set_colorscheme()
