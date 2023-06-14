local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics


local sources = {
  -- null_ls.builtins.formatting.stylua,
  formatting.prettierd,
  -- diagnostics.eslint_d, -- no need for this since we have eslint_lsp
}
null_ls.setup({ sources = sources })


-- install mason sources for linters I do  not have,
-- I still have to manually add them to sources anyways
require('mason-null-ls').setup({
  ensure_installed = nil,
  automatic_installation = true,
  automatic_setup = false,
})
