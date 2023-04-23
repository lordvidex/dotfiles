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
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

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
  use {
    'glepnir/dashboard-nvim',
    config = require('lordvidex.dashboard').setup,
    requires = { 'nvim-tree/nvim-web-devicons' }
  }

  -- Display
  -- Themes
  use 'folke/tokyonight.nvim'
  use 'navarasu/onedark.nvim'
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
  use 'tzachar/cmp-tabnine'
  use 'github/copilot.vim'
  use 'lukas-reineke/indent-blankline.nvim'

  -- DAP
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'nvim-telescope/telescope-dap.nvim'

  -- Snippet support
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  use 'ahmedkhalf/project.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig' -- enable LSP
  use 'glepnir/lspsaga.nvim'
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

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzf-native.nvim'
  use 'christoomey/vim-tmux-navigator' -- tmux navigation made easy

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })
  use 'nvim-treesitter/nvim-treesitter-refactor' -- this provides gotodef when lsp is buggy

  -- Lua
  use 'folke/neodev.nvim'

  -- flutter
  use 'akinsho/flutter-tools.nvim'
  use 'dart-lang/dart-vim-plugin'

  -- Go
  use 'ray-x/go.nvim'
  use { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' }
  use 'leoluz/nvim-dap-go' -- TODO: add keymap and setup for go


  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
  use 'junegunn/gv.vim'
  use 'sindrets/diffview.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
