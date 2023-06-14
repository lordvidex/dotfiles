local servers = {
  jsonls = true,
  lua_ls = true,
  gopls = true,
  tsserver = true,
}

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

local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then
  return
end
mason.setup(settings)

local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if mason_lspconfig_ok then
  mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
  })
end

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

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

if lspconfig_ok and mason_lspconfig_ok then
  mason_lspconfig.setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      local opts = {
        on_attach = require("lordvidex.lsp.handlers").on_attach,
        capabilities = require("lordvidex.lsp.handlers").capabilities,
      }
      local require_ok, conf_opts = pcall(require, "lordvidex.lsp.settings." .. server_name)
      if require_ok then
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
      end
      lspconfig[server_name].setup(opts)
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ["rust_analyzer"] = function()
    --   require("rust-tools").setup {}
    -- end
  }
end
