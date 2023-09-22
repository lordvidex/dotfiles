return {
  'nvim-lualine/lualine.nvim',
  config = function() 
local lualine = require('lualine')
local exists, _ = pcall(require, 'codeium')
local lualine_y = {}
if exists then
  table.insert(lualine_y, '%3{codeium#GetStatusString()}')
end
  table.insert(lualine_y, 'progress')
lualine.setup {
  options = {
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
  },
  sections = {
    lualine_x = {
      {
        'aerial',
        sep = ' ) ',
        depth = nil,
        dense = false,
        dense_sep = '.',
        colored = true,
      }, 'fileformat', 'filetype' },
    lualine_y = lualine_y,
  },
  inactive_sections = {
    lualine_x = { 'encoding' }
  }
}
end,
}
