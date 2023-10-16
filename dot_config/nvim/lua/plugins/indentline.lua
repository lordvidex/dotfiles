return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  config = function()
    local ibl = require "ibl"

    ibl.setup({
      enabled = true,
      indent = { char = "▎" },     --  "▎"
      exclude = {
        filetypes = {
          "help",
          "man",
          "lspinfo",
          "toggleterm",
          'dart', -- exclude dart files
          "packer",
          "NvimTree",
          "gitcommit",
          "checkhealth",
          "Trouble",
          "TelescopePrompt",
          "",
          "TelescopeResults"
        },
      }
    })
  end,
}
