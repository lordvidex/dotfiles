return {
  {
    'folke/neodev.nvim',
    config = function()
      local neodev_ok, neodev = pcall(require, 'neodev')
      if neodev_ok then
        neodev.setup({
          -- important to call before `lspconfig`
          library = {
            plugins = { 'nvim-dap-ui' },
            types = true,
          },
        })
      end
    end
  },
  {
    "mason-org/mason.nvim",
    config = function()
      local settings = {
        ui = {
          border = "none",
          icons = {
            package_installed = "◍",
            package_pending = "◍",
            package_uninstalled = "◍",
          },
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      }
      local mason = require 'mason'
      mason.setup(settings)
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls" },
    },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },
}
