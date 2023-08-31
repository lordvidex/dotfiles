return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local configs = require("nvim-treesitter.configs")

    local enable = true -- use treesitter textobject configs
    local enable_experimental = true

    configs.setup({
      ensure_installed = { "bash", "json", "lua", "typescript", "tsx", "rust", "yaml", "markdown", "markdown_inline",
        "go" }, -- one of "all" or a list of languages
      incremental_selection = {
        enable = enable,
        keymaps = {
          init_selection = "grn",   -- maps in normal mode to init the node/scope selection
          node_incremental = "<CR>", -- increment to the upper named parent
          scope_incremental = "<Tab>", -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "<S-Tab>", -- decrement to the previous node
        },
      },
      textobjects = {
        disable = { 'dart' },
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
            ['@class.outer'] = 'V', -- selecting classes should grab the whole class declaration in Visual Line mode
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
            ["]c"] = { query = "@class.outer", desc = "next start of class" },
            ["]]"] = { query = "@function.outer", desc = "next start of function" },
            ["]l"] = { query = "@loop.*", desc = "next loop" },
          },
          goto_next_end = {
            ["]["] = { query = "@function.outer", desc = "next end of function" },
            ["]C"] = "@class.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
            ["[c"] = "@class.outer",
          },
          goto_previous_end = {
            ["[]"] = '@function.outer',
            ["[C"] = "@class.outer",
          },
        }
      },
      ignore_install = { "phpdoc", "dart" }, -- List of parsers to ignore installing
      auto_install = true,
      highlight = {
        enable = enable, -- false will disable the whole extension
      },
      indent = { enable = enable_experimental, disable = { "python", "css" } },
      context_commentstring = {
        enable = enable,
        disable = { 'dart' },
        enable_autocmd = false,
      },
      playground = {
        enable = enable_experimental,
        updatetime = 25,     -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
    })
  end
}
