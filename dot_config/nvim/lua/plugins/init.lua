return {
  -- install the following configs
  -- Utility
  { 'nvim-lua/plenary.nvim', lazy = true },
  'folke/trouble.nvim',
  { 'nvim-lua/popup.nvim',   lazy = true },
  {
    'mbbill/undotree',
    event = 'BufEnter',
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end
  },
  {
    'echasnovski/mini.files',
    dependencies = 'nvim-tree/nvim-web-devicons',
    cond = false,
    version = '*',
    config = function()
      require('mini.files').setup()
    end
  },
  -- {
  --   'stevearc/stickybuf.nvim',
  --   config = function() require('stickybuf').setup() end
  -- },
  {
    'ggandor/lightspeed.nvim',
    dependencies = { 'tpope/vim-repeat' },
  },
  'mg979/vim-visual-multi', -- multi cursors
  -- 'RRethy/vim-illuminate',     -- highlight instances of the word under the cursor (not needed)

  -- Display
  -- Themes
  { 'folke/tokyonight.nvim',                       lazy = true },
  -- Helpers
  'moll/vim-bbye',

  -- Productivity
  -- 'wakatime/vim-wakatime',
  'tpope/vim-surround',

  -- Snippet support
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',

  -- LSP
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
    }
  }, -- enable LSP
  {
    'ray-x/lsp_signature.nvim',
    config = function()
      require('lsp_signature').setup()
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
  },
  'jay-babu/mason-nvim-dap.nvim',
  { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true },
  'jose-elias-alvarez/null-ls.nvim',
  --
  -- Telescope

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  { 'nvim-treesitter/playground',               dependencies = 'nvim-treesitter/nvim-treesitter' },
  { 'nvim-treesitter/nvim-treesitter-refactor', dependencies = 'nvim-treesitter/nvim-treesitter' }, -- this provides gotodef when lsp is buggy

  -- flutter
  { 'dart-lang/dart-vim-plugin',                ft = 'dart' },

  -- 'fatih/vim-go',
  {
    'lordvidex/go-heat.nvim',
    lazy = true,
    config = function()
      require('go-heat').setup({
        open_in = 'terminal',
      })
    end
  },
  -- LaTeX
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_view_skim_reading_bar = 1
      -- vim.g.
    end
  },
  'terrastruct/d2-vim',

  -- Rust
  -- 'simrat39/rust-tools.nvim', -- not needed LSP is enough
  -- assembly
  'p00f/godbolt.nvim',
}
