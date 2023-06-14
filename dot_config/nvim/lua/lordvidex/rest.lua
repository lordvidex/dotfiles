local _, whichkey = pcall(require, 'which-key')
local restok, rest = pcall(require, 'rest-nvim')
if not restok then
  return
end
-- initialise rest
rest.setup {}

-- add keymaps
local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<localleader>",
  silent = true,
  noremap = true,
  nowait = true,
}
local mappings = {
  r = {
    name = "Rest Nvim",
    r = { "<Plug>RestNvim", "Run rest.nvim in the current cursor position"},
    p = { "<Plug>RestNvimPreview", "returns curl command for request"},
    -- e = {"<cmd>RestSelectEnv ", "set the path to an env file"},
  }
}
whichkey.register(mappings, opts)
