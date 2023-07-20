local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- This is dangerous as it syncs updates and they might contain breaking changes
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

require('packer').startup(function(use)
  -- install the following configs
  -- Utility
  use 'wbthomason/packer.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'akinsho/toggleterm.nvim'
  use 'folke/trouble.nvim'
  use 'nvim-lua/popup.nvim'
  use 'mbbill/undotree'
  use 'stevearc/aerial.nvim' -- Lspsaga outline is complementary as well
  -- use {
  --   'stevearc/stickybuf.nvim',
  --   config = function() require('stickybuf').setup() end
  -- }
  use { 'ggandor/lightspeed.nvim',
    requires = { 'tpope/vim-repeat' },
  }
  use 'mg979/vim-visual-multi' -- multi cursors
  use {
    'rest-nvim/rest.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  -- use 'RRethy/vim-illuminate'     -- highlight instances of the word under the cursor (not needed)
  use {
    'glepnir/dashboard-nvim',
    config = require('lordvidex.dashboard').setup,
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  -- Display
  -- Themes
  use 'folke/tokyonight.nvim'
  use { 'catppuccin/nvim', as = "catppuccin" }
  -- Helpers
  use 'akinsho/bufferline.nvim'
  use 'moll/vim-bbye'
  use 'nvim-lualine/lualine.nvim'

  -- Productivity
  use 'wakatime/vim-wakatime'
  use 'vimwiki/vimwiki'
  use 'folke/which-key.nvim'
  use {
    "nvim-tree/nvim-tree.lua",       -- https://github.com/nvim-tree/nvim-tree.lua
    requires = {
      "nvim-tree/nvim-web-devicons", -- https://github.com/nvim-tree/nvim-web-devicons
    },
  }
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-surround'

  -- CMP
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  -- autocompletion: codeium = tabnine + copilot (but codeium has issues, jeez, messing with <Esc> and insert mode)
  -- use { 'Exafunction/codeium.vim', config = function()
  --   vim.keymap.set('i', '<Tab>', function() return vim.fn['codeium#Accept']() end, { expr = true })
  --   vim.keymap.set('i', '<c-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
  --   vim.keymap.set('i', '<c-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
  --   vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
  -- end,
  -- }
  -- use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' } -- #uses too much memory
  use 'github/copilot.vim'
  use 'lukas-reineke/indent-blankline.nvim'

  -- DAP
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'
  --
  -- Snippet support
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  use 'ahmedkhalf/project.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig' -- enable LSP
  use {
    'glepnir/lspsaga.nvim',
    commit = "8ea2afc51c548f2a468115d8f6bba57ac3957ef8"
  }
  use 'ray-x/lsp_signature.nvim'
  use {
    "williamboman/mason.nvim",
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
  }
  use 'williamboman/mason-lspconfig.nvim'
  use 'jay-babu/mason-null-ls.nvim'
  use 'jay-babu/mason-nvim-dap.nvim'
  use 'numToStr/Comment.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'jose-elias-alvarez/null-ls.nvim'
  --
  -- Telescope
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.1' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'christoomey/vim-tmux-navigator' -- tmux navigation made easy
  --
  -- -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })
  use { 'nvim-treesitter/playground', requires = 'nvim-treesitter/nvim-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter-refactor', requires = 'nvim-treesitter/nvim-treesitter' } -- this provides gotodef when lsp is buggy

  -- Lua
  use 'folke/neodev.nvim'

  -- flutter
  use 'akinsho/flutter-tools.nvim'
  use 'dart-lang/dart-vim-plugin'

  -- Go
  use 'ray-x/go.nvim'
  -- use 'fatih/vim-go'
  use { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' }
  use { 'lordvidex/go-heat.nvim',
    config = function()
      require('go-heat').setup({
        open_in = 'terminal',
      })
    end
  }
  -- use 'leoluz/nvim-dap-go' -- TODO: add keymap and setup for go

  -- Rust
  -- use 'simrat39/rust-tools.nvim' -- not needed LSP is enough

  -- Markdown
  use { 'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install', ft = 'markdown' }

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'junegunn/gv.vim'
  use 'sindrets/diffview.nvim'

  -- assembly
  use 'p00f/godbolt.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
