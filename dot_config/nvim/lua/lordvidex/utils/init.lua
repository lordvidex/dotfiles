local M = {}
-- Enable autosave for the current buffer
local function autowrite()
  vim.o.autowrite = true
  vim.cmd [[
  augroup AutoWrite
    autocmd!
    autocmd BufLeave,FocusLost,InsertLeave,TextChanged,CursorHold * if &modifiable | silent write | endif
  augroup END

  ]]
end

M.autowrite = autowrite

return M
