return {
  "nvim-tree/nvim-tree.lua",       -- https://github.com/nvim-tree/nvim-tree.lua
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- https://github.com/nvim-tree/nvim-web-devicons
  },
  config = function()
    local nvim_tree = require'nvim-tree'

    -- on_attach function for key mappings to the buffer
    local function on_attach(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end


      -- Default mappings. Feel free to modify or remove as you wish.
      --
      -- BEGIN_DEFAULT_ON_ATTACH
      api.config.mappings.default_on_attach(bufnr)
      -- END_DEFAULT_ON_ATTACH


      -- You will need to insert "your code goes here" for any mappings with a custom action_cb
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
    end

    -- setup begins
    nvim_tree.setup {
      disable_netrw = true,
      hijack_netrw = true,
      update_focused_file = {
        enable = true,
        update_cwd = false,
      },
      on_attach = on_attach,
      filters = {
        dotfiles = false, custom = { '^.git$' },
      },
      renderer = {
        root_folder_modifier = ":t",
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed = "➜",
              untracked = "U",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      git = {
        ignore = false,
      },
      view = {
        width = 30,
        side = "left",
      },
    }
  end,
}
