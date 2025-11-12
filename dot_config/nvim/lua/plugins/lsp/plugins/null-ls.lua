-- runtime toggle flag
_G.FIELDALIGN_ON = true

return {
  -- 1) none-ls (null-ls fork)
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls      = require("null-ls")
      local formatting   = null_ls.builtins.formatting

      null_ls.setup({
        sources = {
          -- formatters
          formatting.prettierd,
        },
      })
    end,
  },
  -- 2) mason-null-ls — install tools ONLY (no auto registering)
  {
    "jay-babu/mason-null-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "mason-org/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = { "prettierd" },
      automatic_installation = true,
      -- IMPORTANT: don't auto-setup sources; we registered them ourselves above
      handlers = {},
      -- If you're on an older mason-null-ls that still uses this flag, keep it false:
      -- automatic_setup = false,
    },
  },
}

