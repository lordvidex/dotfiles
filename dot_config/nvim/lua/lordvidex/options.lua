local options = {
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = false,                        -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        --smart case
  smartindent = true,                      --make indenting smarter again
  splitbelow = true,                       -- forces all horizontal splits to go below the current window
  splitright = true,                       -- forces all vertical splits to go to the right of the current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set termguicolors (most terminals support this)
  timeoutlen = 1000,                       --time to wait for a mapped sequence to complete (in milliseconds)
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tab to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current cursor
  syntax = 'off',                          -- stops highlighting with regex
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                            -- display lines as one long line
  scrolloff = 8,                           -- leaves 8 vertical lines at the top / bottom while scrolling
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,                         -- enable persistent undo
}
-- vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.editorconfig = false
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "set autowriteall"         -- saves file when switching buffers for all files
vim.cmd "set autowrite"            -- saves file when switching buffers
-- vim.cmd [[set iskeyword=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
