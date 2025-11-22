-- plugins/lsp/gopls_guard.lua
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= "gopls" then
      return
    end

    local bufnr = args.buf
    local name = vim.api.nvim_buf_get_name(bufnr)
    local is_virtual = (name == "") or name:match("^[%a][%w+.-]*://")

    if is_virtual then
      vim.schedule(function()
        pcall(vim.lsp.buf_detach_client, bufnr, client.id)
      end)
    end
  end,
})

