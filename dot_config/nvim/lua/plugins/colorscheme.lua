return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  config = function()
    local present, catppuccin = pcall(require, 'catppuccin')
    if not present then return end
    local transparent_background = false
    catppuccin.setup({
      flavour = 'mocha',
    })
    vim.cmd.colorscheme "catppuccin"
  end
}
