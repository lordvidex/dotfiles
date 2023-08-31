-- Set the filetype to 'toml' for .toml and .conf files
vim.cmd([[
    augroup toml_filetype
    autocmd!
    autocmd BufRead,BufNewFile *.conf setlocal filetype=toml
    autocmd BufRead,BufNewFile *.toml.tpl,*.conf.tpl setlocal filetype=toml
    augroup END
]])
