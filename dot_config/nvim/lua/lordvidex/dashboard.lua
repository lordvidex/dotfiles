local M = {}
M.setup = function()
  require('dashboard').setup {
    theme = 'hyper',
    config = {
      week_header = {
        enable = true,
      },
      shortcut = {
        { desc = ' Update', group = '@property', action = 'PackerUpdate', key = 'u' },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' dotfiles',
          group = 'Number',
          action = "execute 'cd ~/.config/nvim' | e init.lua",
          key = 'd',
        },
      },
    },
  }
end
return M
