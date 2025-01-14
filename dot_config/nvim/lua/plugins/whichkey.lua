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


    local global_mappings = {
      { "<leader>c",  "<cmd>Bdelete<CR>",                                                      desc = "Close Buffer",               nowait = true, remap = false },
      { "<leader>e",  "<cmd>Neotree toggle reveal<CR>",                                        desc = "Explorer",                   nowait = true, remap = false },
      { "<leader>f",  group = "Telescope [Find]",                                              nowait = true,                       remap = false },
      { "<leader>f/", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", desc = "Find in current buffer",     nowait = true, remap = false },
      { "<leader>fR", "<cmd>Telescope registers<CR>",                                          desc = "Registers",                  nowait = true, remap = false },
      { "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>",                   desc = "Find in [b]uffers",          nowait = true, remap = false },
      { "<leader>fc", "<cmd>Telescope commands<CR>",                                           desc = "Commands",                   nowait = true, remap = false },
      { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>",                desc = "Find files",                 nowait = true, remap = false },
      { "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>",                 desc = "Find Text [g]rep search",    nowait = true, remap = false },
      { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>",                 desc = "Find in [h]elp",             nowait = true, remap = false },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>",                                            desc = "Keymaps",                    nowait = true, remap = false },
      { "<leader>fl", "<cmd>Telescope resume<CR>",                                             desc = "Resume last picker",         nowait = true, remap = false },
      { "<leader>fm", "<cmd>Telescope man_pages<CR>",                                          desc = "Man Pages",                  nowait = true, remap = false },
      { "<leader>fp", "<cmd>lua require('telescope').extensions.projects.projects()<CR>",      desc = "Projects",                   nowait = true, remap = false },
      { "<leader>fr", "<cmd>Telescope oldfiles<CR>",                                           desc = "Open Recent File",           nowait = true, remap = false },
      { "<leader>fx", "<cmd>lua require('telescope.builtin').treesitter()<CR>",                desc = "Treesitter",                 nowait = true, remap = false },
      { "<leader>g",  group = "Git",                                                           nowait = true,                       remap = false },
      { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<CR>",                        desc = "Reset Buffer",               nowait = true, remap = false },
      { "<leader>gb", "<cmd>Telescope git_branches<CR>",                                       desc = "Checkout branch",            nowait = true, remap = false },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>",                                        desc = "Checkout commit",            nowait = true, remap = false },
      { "<leader>gd", "<cmd>DiffviewOpen<CR>",                                                 desc = "Diff",                       nowait = true, remap = false },
      { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<CR>",                          desc = "Blame",                      nowait = true, remap = false },
      { "<leader>go", "<cmd>Telescope git_status<CR>",                                         desc = "Open changed file",          nowait = true, remap = false },
      { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<CR>",                        desc = "Preview Hunk",               nowait = true, remap = false },
      { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<CR>",                          desc = "Reset Hunk",                 nowait = true, remap = false },
      { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<CR>",                          desc = "Stage Hunk",                 nowait = true, remap = false },
      { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",                     desc = "Undo Stage Hunk",            nowait = true, remap = false },
      { "<leader>l",  group = "LSP",                                                           nowait = true,                       remap = false },
      { "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<CR>",                                   desc = "CodeLens Action",            nowait = true, remap = false },
      { "<leader>lO", "<cmd>Lspsaga outline<CR>",                                              desc = "Lspsaga [O]utline",          nowait = true, remap = false },
      { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",                      desc = "Workspace Symbols",          nowait = true, remap = false },
      { "<leader>lb", "<cmd>Lspsaga show_buf_diagnostics<CR>",                                 desc = "Show Buffer Diagnostics",    nowait = true, remap = false },
      { "<leader>lc", "<cmd>Lspsaga show_cursor_diagnostics<CR>",                              desc = "Show Cursor Diagnostics",    nowait = true, remap = false },
      { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<CR>",                                desc = "Document Diagnostics",       nowait = true, remap = false },
      { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<CR>",                           desc = "Format",                     nowait = true, remap = false },
      { "<leader>li", "<cmd>Lspsaga incoming_calls<CR>",                                       desc = "Incoming Calls",             nowait = true, remap = false },
      { "<leader>ll", "<cmd>Lspsaga show_line_diagnostics<CR>",                                desc = "Show Line Diagnostics",      nowait = true, remap = false },
      { "<leader>lo", "<cmd>Lspsaga outgoing_calls<CR>",                                       desc = "Outgoing Calls",             nowait = true, remap = false },
      { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>",                              desc = "Quickfix",                   nowait = true, remap = false },
      { "<leader>lr", "<cmd>Lspsaga rename<CR>",                                               desc = "Rename",                     nowait = true, remap = false },
      { "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>",                               desc = "Document Symbols",           nowait = true, remap = false },
      { "<leader>lw", "<cmd>Lspsaga show_workspace_diagnostics<CR>",                           desc = "Show Workspace Diagnostics", nowait = true, remap = false },
      { "<leader>p",  "<cmd>ProjectRoot<CR>",                                                  desc = "Set project root",           nowait = true, remap = false },
      { "<leader>s",  "<cmd>Navbuddy<CR>",                                                     desc = "buffer [s]ymbols",           nowait = true, remap = false },
      { "<leader>u",  "<cmd>UndotreeToggle<CR>",                                               desc = "UndoTree",                   nowait = true, remap = false },
    }

    local local_mappings = {
      { "<localleader>g",   group = "Golang",              nowait = true,                            remap = false },
      { "<localleader>gc",  "<cmd>GoCmt<CR>",              desc = "Generate comment",                nowait = true, remap = false },
      { "<localleader>ge",  "<cmd>GoIfErr<CR>",            desc = "Add if err",                      nowait = true, remap = false },
      { "<localleader>gi",  "<cmd>GoToggleInlay<CR>",      desc = "Toggle inlay",                    nowait = true, remap = false },
      { "<localleader>gl",  "<cmd>GoLint<CR>",             desc = "Run linter",                      nowait = true, remap = false },
      { "<localleader>gm",  group = "Mod",                 nowait = true,                            remap = false },
      { "<localleader>gmi", "<cmd>GoModInit<CR>",          desc = "Go mod init",                     nowait = true, remap = false },
      { "<localleader>gmt", "<cmd>GoModTidy<CR>",          desc = "Go mod tidy",                     nowait = true, remap = false },
      { "<localleader>go",  "<cmd>GoPkgOutline<CR>",       desc = "Outline",                         nowait = true, remap = false },
      { "<localleader>gr",  "<cmd>GoRun<CR>",              desc = "Run",                             nowait = true, remap = false },
      { "<localleader>gs",  group = "Struct",              nowait = true,                            remap = false },
      { "<localleader>gsa", "<cmd>GoAddTag<CR>",           desc = "Add tags to struct",              nowait = true, remap = false },
      { "<localleader>gsc", "<cmd>GoClearTag<CR>",         desc = "Clear tags",                      nowait = true, remap = false },
      { "<localleader>gsf", "<cmd>GoFillStruct<CR>",       desc = "[F]ill the Struct",               nowait = true, remap = false },
      { "<localleader>gsr", "<cmd>GoRmTag<CR>",            desc = "Remove tags to struct",           nowait = true, remap = false },
      { "<localleader>gt",  group = "Tests",               nowait = true,                            remap = false },
      { "<localleader>gtA", "<cmd>GoAddExpTest<CR>",       desc = "Add test to func with example",   nowait = true, remap = false },
      { "<localleader>gtF", "<cmd>GoTestFile<CR>",         desc = "Run test for current file",       nowait = true, remap = false },
      { "<localleader>gta", "<cmd>GoAddTest<CR>",          desc = "Add test to func",                nowait = true, remap = false },
      { "<localleader>gtc", "<cmd>GoCoverage<CR>",         desc = "Test coverage",                   nowait = true, remap = false },
      { "<localleader>gtf", "<cmd>GoTestFunc<CR>",         desc = "Run test for current func",       nowait = true, remap = false },
      { "<localleader>gtr", "<cmd>GoTest<CR>",             desc = "Run tests",                       nowait = true, remap = false },
      { "<localleader>gts", "<cmd>GoAltS!<CR>",            desc = "Open alt file in split",          nowait = true, remap = false },
      { "<localleader>gtv", "<cmd>GoAltV!<CR>",            desc = "Open alt file in vertical split", nowait = true, remap = false },
      { "<localleader>gv",  "<cmd>GoVet<CR>",              desc = "Go vet",                          nowait = true, remap = false },
      { "<localleader>gx",  group = "Code Lens",           nowait = true,                            remap = false },
      { "<localleader>gxa", "<cmd>GoCodeAction<CR>",       desc = "Code Action",                     nowait = true, remap = false },
      { "<localleader>gxl", "<cmd>GoCodeLenAct<CR>",       desc = "Toggle Lens",                     nowait = true, remap = false },
      { "<localleader>m",   group = "Markdown",            nowait = true,                            remap = false },
      { "<localleader>ma",  "<Plug>MarkdownPreview",       desc = "St[a]rt markdown Preview",        nowait = true, remap = false },
      { "<localleader>mm",  "<Plug>MarkdownPreviewToggle", desc = "Toggle [M]arkdown Preview",       nowait = true, remap = false },
      { "<localleader>ms",  "<Plug>MarkdownPreviewStop",   desc = "[S]top Markdown Preview",         nowait = true, remap = false },
    }


    which_key.setup(setup)
    which_key.add(global_mappings)
    which_key.add(local_mappings)
  end
}
