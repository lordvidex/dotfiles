return {
  {
    'mzlogin/vim-markdown-toc',
    ft = 'markdown',
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = 'markdown',
    lazy = true,
  },
  {
    'vimwiki/vimwiki',
    init = function()
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_list = {
        {
          path = '$HOME/Documents/vimwiki',
          syntax = 'markdown',
          path_html = '$HOME/Documents/vimwiki_html',
          custom_wiki2html = 'vimwiki_markdown',
          html_filename_parameterization = 1,
          ext = '.md',
        },
        {
          path = '$HOME/Documents/vimwiki/paytrybe',
          syntax = 'markdown',
          custom_wiki2html = '$HOME/scripts/wiki2html.sh',
          path_html = '$HOME/Documents/vimwiki_html/paytrybe',
          html_filename_parameterization = 1,
          ext = '.md',
        }
      }
    end
  } }
