local toggleterm = require("toggleterm")
toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  local bufmap = vim.api.nvim_buf_set_keymap
  bufmap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  bufmap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  bufmap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  bufmap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  bufmap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  bufmap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)

  bufmap(0, 't', '<leader>tf', '<cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', opts)
  bufmap(0, 't', '<leader>ts', '<cmd>exe v:count1 . "ToggleTerm direction=horizontal size=10"<CR>', opts)
  bufmap(0, 't', '<leader>tv', '<cmd>exe v:count1 . "ToggleTerm direction=vertical size=80"<CR>', opts)
end

vim.cmd('autocmd! TermEnter term://*toggleterm#* lua set_terminal_keymaps()') -- only register these commands when toggleterm is opened

-- register terminal keymap commands for opening toggleterm
local map = vim.api.nvim_set_keymap

local modes = { 'i', 'n' }
for _, mode in ipairs(modes) do
  local esc = mode == 'i' and '<esc>' or ''
  map('n', '<leader>tf', esc .. '<cmd>exe v:count1 . "ToggleTerm direction=float"<CR>', { silent = true })
  map('n', '<leader>ts', esc .. '<cmd>exe v:count1 . "ToggleTerm direction=horizontal size=10"<CR>', { silent = true })
  map('n', '<leader>tv', esc .. '<cmd>exe v:count1 . "ToggleTerm direction=vertical size=80"<CR>', { silent = true })
end
