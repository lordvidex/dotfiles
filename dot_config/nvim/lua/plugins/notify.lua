return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  opts = {
    -- add any options here
  },
  config = function()
    vim.notify = require("notify")
    require('notify').setup()
  end
}
