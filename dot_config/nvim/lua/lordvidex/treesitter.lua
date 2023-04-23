local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

local enable = true -- use treesitter textobject configs

configs.setup({
  ensure_installed = { "bash", "json", "lua", "typescript", "tsx", "rust", "yaml", "markdown", "markdown_inline",
    "go" }, -- one of "all" or a list of languages
  incremental_selection = {
    enable = enable,
    keymaps = {
      init_selection = "gnn",    -- maps in normal mode to init the node/scope selection
      node_incremental = "grn",  -- increment to the upper named parent
      scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
      node_decremental = "grm",  -- decrement to the previous node
    },
  },
  textobjects = {
    -- syntax-aware textobjects
    enable = enable,
    lsp_interop = {
      enable = enable,
      border = "none",
      peek_definition_code = {
        ["<leader>lpf"] = "@function.outer",
        ["<leader>lpc"] = "@class.outer",
      },
    },
    -- select mode
    select = {
      enable = enable,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- ["iL"] = {
          -- you can define your own textobjects directly here
          -- go = "(function_definition) @function",
        -- },
        -- or you use the queries from supported languages with textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["ae"] = "@block.outer",
        ["ie"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["is"] = "@statement.inner",
        ["as"] = "@statement.outer",
        ["ad"] = "@comment.outer",
        ["am"] = "@call.outer",
        ["im"] = "@call.inner",
      },
      selection_modes = {
        ['@parameter.outer'] = 'v',
        ['@function.outer'] = 'V',
        ['@class.outer'] = '<c-v>',
      },
    },
    -- swapping
    -- swap = {
    --   enable = enable,
    --   swap_next = {
    --     ["<leader>a"] = "@parameter.inner",
    --   },
    --   swap_previous = {
    --     ["<leader>A"] = "@parameter.inner",
    --   },
    -- },
    -- move to next or previous textobject
    move = {
      enable = enable,
      set_jumps = true, -- whether to set jump in the jumplist
      goto_next_start = {
        ["]]"] = { query = "@class.outer", desc = "next start of class" },
        ["]m"] = "@function.outer",
        ["]o"] = { query = "@loop.*", desc = "next loop" },
      },
      goto_next_end = {
        ["]M"] = { query = "@function.outer", desc = "next end of function" },
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = '@function.outer',
        ["[]"] = "@class.outer",
      },
    }
  },
  ignore_install = { "phpdoc" }, -- List of parsers to ignore installing
  auto_install = true,
  highlight = {
    enable = true,       -- false will disable the whole extension
    disable = { "css" }, -- list of language that will be disabled
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "css" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
})

local ok, ts_repeat_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
if not ok then
  -- print warning
  print("Treesitter textobjects repeatable move not found")
  return
end
-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
