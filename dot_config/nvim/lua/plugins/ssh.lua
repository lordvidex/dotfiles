return {
  'amitds1997/remote-nvim.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'rcarriga/nvim-notify'
  },
  config = function ()
    require('remote-nvim').setup()
  end,
}
