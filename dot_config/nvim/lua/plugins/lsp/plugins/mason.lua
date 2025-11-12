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
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "neovim/nvim-lspconfig",
  --     'folke/neodev.nvim',
  --   },
  --   config = function()
  --     local servers = {
  --       jsonls = true,
  --       lua_ls = true,
  --       gopls = true,
  --       tsserver = true,
  --       yamlls = true,
  --     }
  --
  --     local mason_lspconfig = require 'mason-lspconfig'
  --     local ensure_installed = vim.tbl_keys(servers)
  --     mason_lspconfig.setup {
  --       ensure_installed = ensure_installed,
  --       automatic_enable = false,
  --     }
  --
  --     local lspconfig = require "lspconfig"
  --     local handlers = require("plugins.lsp.handlers")
  --
  --     local blink_ok, blink = pcall(require, 'blink.cmp')
  --     local base_capabilities = handlers.capabilities or vim.lsp.protocol.make_client_capabilities()
  --     if blink_ok then
  --       base_capabilities = require('blink.cmp').get_lsp_capabilities(base_capabilities)
  --     end
  --
  --     local function setup_server(server_name)
  --       local opts = {
  --         on_attach = handlers.on_attach,
  --         capabilities = base_capabilities,
  --       }
  --       local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server_name)
  --       if require_ok and type(conf_opts) == 'table' then
  --         opts = vim.tbl_deep_extend("force", conf_opts, opts)
  --       end
  --       if not lspconfig[server_name] then
  --         vim.notify("lspconfig does not have configuration for " .. server_name, vim.log.levels.WARN)
  --         return
  --       end
  --       lspconfig[server_name].setup(opts)
  --     end
  --
  --     for server_name in pairs(servers) do
  --       setup_server(server_name)
  --     end
  --   end,
  -- },
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
