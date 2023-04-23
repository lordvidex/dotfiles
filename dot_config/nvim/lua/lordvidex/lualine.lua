local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end
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
  },
  inactive_sections = {
    lualine_x = {'encoding'}
  }
}
