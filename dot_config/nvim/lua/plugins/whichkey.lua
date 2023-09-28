return {
  'folke/which-key.nvim',
  config = function()
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
      return
    end

    local setup = {
      {
        plugins = {
          marks = true,       -- shows a list of your marks on ' and `
          registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,            -- bindings for folds, spelling and others prefixed with z
            g = true,            -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comments" },
        key_labels = {
          -- override the label used to display some keys. It doesn't e
          -- f = { "<cmd>"}ffect WK in any other way.
          -- For example:
          -- ["<space>"] = "SPC",
          -- ["<CR>"] = "RET",
          -- ["<tab>"] = "TAB",
        },
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>",   -- binding to scroll up inside the popup
        },
        window = {
          border = "rounded",       -- none, single, double, shadow
          position = "bottom",      -- bottom, top
          margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 },                                             -- min and max height of the columns
          width = { min = 20, max = 50 },                                             -- min and max width of the columns
          spacing = 3,                                                                -- spacing between columns
          align = "left",                                                             -- align columns left, center or right
        },
        ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true,                                                             -- show help message on the command line when the popup is visible
        triggers = { "auto" },
        triggers_nowait = {
          -- marks
          "`",
          "'",
          "g`",
          "g'",
          -- registers
          '"',
          "<c-r>",
          -- spelling
          "z=",
        },
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
      }
    }

    local global_opts = {
      mode = "n",     -- NORMAL mode
      prefix = "<leader>",
      buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true,  -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true,  -- use `nowait` when creating keymaps
    }

    local global_mappings = {
      ["a"] = { "<cmd>Navbuddy<CR>", "show buffer symbols" },
      ["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
      ["c"] = { "<cmd>Bdelete<CR>", "Close Buffer" },
      ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
      ["u"] = { "<cmd>UndotreeToggle<CR>", "UndoTree" },
      p = { "<cmd>ProjectRoot<CR>", "Set project root" },
      f = {
        name = "Telescope [Find]",
        f = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find files" },
        g = { "<cmd>lua require('telescope.builtin').live_grep()<CR>", "Find Text [g]rep search" },
        b = { "<cmd>lua require('telescope.builtin').buffers()<CR>", "Find in [b]uffers" },
        h = { "<cmd>lua require('telescope.builtin').help_tags()<CR>", "Find in [h]elp" },
        x = { "<cmd>lua require('telescope.builtin').treesitter()<CR>", "Treesitter" },
        p = { "<cmd>lua require('telescope').extensions.projects.projects()<CR>", "Projects" },
        ["/"] = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", "Find in current buffer" },
        m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
        r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
        R = { "<cmd>Telescope registers<CR>", "Registers" },
        k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
        c = { "<cmd>Telescope commands<CR>", "Commands" },
        l = { "<cmd>Telescope resume<CR>", "Resume last picker" },
      },
      g = {
        name = "Git",
        l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
        p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
        r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
        R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
        s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
        u = {
          "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
          "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
        d = { "<cmd>DiffviewOpen<CR>", "Diff" }
      },
      l = {
        name = "LSP",
        d = {
          "<cmd>Telescope diagnostics bufnr=0<CR>",
          "Document Diagnostics",
        },
        i = { "<cmd>Lspsaga incoming_calls<CR>", "Incoming Calls" },
        o = { "<cmd>Lspsaga outgoing_calls<CR>", "Outgoing Calls" },
        O = { "<cmd>Lspsaga outline<CR>", "Lspsaga [O]utline" },
        f = { "<cmd>lua vim.lsp.buf.format{async=true}<CR>", "Format" },
        l = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostics" },
        b = { "<cmd>Lspsaga show_buf_diagnostics<CR>", "Show Buffer Diagnostics" },
        w = { "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Show Workspace Diagnostics" },
        c = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show Cursor Diagnostics" },
        L = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
        q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
        r = { "<cmd>Lspsaga rename<CR>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        S = {
          "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
          "Workspace Symbols",
        },
      },
    }

    local local_opts = {
      mode = "n",
      prefix = "<localleader>",
      silent = true,
      noremap = true,
      nowait = true,
    }

    local local_mappings = {
      m = {
        name = "Markdown",
        m = { "<Plug>MarkdownPreviewToggle", "Toggle [M]arkdown Preview" },
        a = { "<Plug>MarkdownPreview", "St[a]rt markdown Preview" },
        s = { "<Plug>MarkdownPreviewStop", "[S]top Markdown Preview" },
      }
    }


    which_key.setup(setup)
    which_key.register(global_mappings, global_opts)
    which_key.register(local_mappings, local_opts)
  end
}
