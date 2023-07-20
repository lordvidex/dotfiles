require('lspsaga').setup {
  ui = {
    -- This option only works in Neovim 0.9
    -- Border type can be single, double, rounded, solid, shadow.
    border = "rounded",
    winblend = 0,
    expand = "",
    collapse = "",
    code_action = "💡",
    incoming = " ",
    outgoing = " ",
    hover = ' ',
    -- kind = {},
  },
  symbol_in_winbar = {
    enable = true,
    separator = " > ",
    ignore_patterns = {},
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
  },
  definition = {
    keys = {
      edit = '<C-c>o',
      vsplit = '<C-c>v',
      split = '<C-c>s',
      tabe = '<C-c>t',
      close = '<C-c>c',
    }
  },
  finder = {
    keys = {
      vsplit = 'v',
      split = 's',
      close = '<C-c>c',
    }
  },
}
