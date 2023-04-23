local servers = {
  jsonls = true,
  lua_ls = true,
  gopls = true,
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


require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

require('neodev').setup({
  library = { plugins = { 'nvim-dap-ui' }, types = true },
}) -- important to call before `lspconfig`

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

require("mason-lspconfig").setup_handlers {
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
