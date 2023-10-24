local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

-- attaches go specific keybinds to the <localleader>
-- TODO: use autocmd to allow only *.go files
local attach_go_keybindings = function()
  local wk = require("which-key")
  local default_options = { silent = true }
  wk.register({
    g = {
      name = "Golang",
      e = { "<cmd>GoIfErr<CR>", "Add if err" },
      s = {
        name = "Struct",
        f = { "<cmd>GoFillStruct<CR>", "[F]ill the Struct" },
        a = { "<cmd>GoAddTag<CR>", "Add tags to struct" },
        r = { "<cmd>GoRmTag<CR>", "Remove tags to struct" },
        c = { "<cmd>GoClearTag<CR>", "Clear tags" },
      },
      v = { "<cmd>GoVet<CR>", "Go vet" },
      c = { "<cmd>GoCmt<CR>", "Generate comment" },
      m = {
        name = "Mod",
        t = { "<cmd>GoModTidy<CR>", "Go mod tidy" },
        i = { "<cmd>GoModInit<CR>", "Go mod init" },
      },
      i = { "<cmd>GoToggleInlay<CR>", "Toggle inlay" },
      l = { "<cmd>GoLint<CR>", "Run linter" },
      o = { "<cmd>GoPkgOutline<CR>", "Outline" },
      r = { "<cmd>GoRun<CR>", "Run" },
      t = {
        name = "Tests",
        a = { "<cmd>GoAddTest<CR>", "Add test to func" },
        A = { "<cmd>GoAddExpTest<CR>", "Add test to func with example" },
        r = { "<cmd>GoTest<CR>", "Run tests" },
        s = { "<cmd>GoAltS!<CR>", "Open alt file in split" },
        v = { "<cmd>GoAltV!<CR>", "Open alt file in vertical split" },
        f = { "<cmd>GoTestFunc<CR>", "Run test for current func" },
        F = { "<cmd>GoTestFile<CR>", "Run test for current file" },
        c = { "<cmd>GoCoverage<CR>", "Test coverage" },
      },
      x = {
        name = "Code Lens",
        l = { "<cmd>GoCodeLenAct<CR>", "Toggle Lens" },
        a = { "<cmd>GoCodeAction<CR>", "Code Action" },
      },
    },
  }, { prefix = "<localleader>", mode = "n", default_options })
  wk.register({
    c = {
      -- name = "Coding",
      j = { "<cmd>'<,'>GoJson2Struct<CR>", "Json to struct" },
    },
  }, { prefix = "<localleader>", mode = "v", default_options })
end

local ok, conf_opts = pcall(require, "plugins.lsp.settings.gopls")
if not ok then
  conf_opts = false
else
  for _, v in ipairs(conf_opts) do
    print(v)
  end
end

-- go.nvim setup
return {
  'ray-x/go.nvim',
  dependencies = {
    { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },
  },
  commit = 'd73ea5bc00f0d7b726b0ddfc29cea17a544459ba',
  config = function()
    local go = require 'go'
    go.setup {
      -- NOTE: all LSP and formatting related options are disabeld.
      -- NOTE: is not related to core.plugins.lsp
      -- NOTE: manages LSP on its own
      go = "go",                -- go command, can be go[default] or go1.18beta1
      goimport = "gopls",       -- goimport command, can be gopls[default] or goimport
      fillstruct = "gopls",     -- can be nil (use fillstruct, slower) and gopls
      gofmt = "gofumpt",        -- gofmt cmd,
      max_line_len = 120,       -- max line length in goline format
      tag_transform = false,    -- tag_transfer  check gomodifytags for details
      test_template = "",       -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
      test_template_dir = "",   -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
      comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ       
      -- icons = { breakpoint = icons.ui.Yoga, currentpos = icons.ui.RunningMan },
      verbose = false,          -- output loginf in messages
      lsp_cfg = conf_opts,      -- true: use non-default gopls setup specified in go/lsp.lua
      -- false: do nothing
      -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
      --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
      lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
      --      when lsp_cfg is true
      -- if lsp_on_attach is a function: use this function as on_attach function for gopls
      lsp_codelens = true, -- set to false to disable codelens, true by default
      lsp_on_attach = function(client, bufnr)
        local semantic = client.config.capabilities.textDocument.semanticTokens
        local provider = client.server_capabilities.semanticTokensProvider
        if semantic then
          client.server_capabilities.semanticTokensProvider =
              vim.tbl_deep_extend('force', provider or {}, {
                full = true,
                legend = {
                  tokenTypes = {
                    'namespace',
                    'type',
                    'class',
                    'enum',
                    'interface',
                    'struct',
                    'typeParameter',
                    'parameter',
                    'variable',
                    'property',
                    'enumMember',
                    'event',
                    'function',
                    'method',
                    'macro',
                    'keyword',
                    'modifier',
                    'comment',
                    'string',
                    'number',
                    'regexp',
                    'operator',
                  },
                  tokenModifiers = {
                    'declaration',
                    'definition',
                    'readonly',
                    'static',
                    'deprecated',
                    'abstract',
                    'async',
                    'modification',
                    'documentation',
                    'defaultLibrary',
                  },
                },
                range = true,
              })
        end
        require('plugins.lsp.handlers').on_attach(client, bufnr)
        attach_go_keybindings()
      end,
      diagnostic = {
        hdlr = true,
        signs = true,
        underline = false,
        update_in_insert = true,
        -- virtual_text = { space = 0, prefix = icons.arrows.Diamond },
      },
      lsp_document_formatting = true,
      -- set to true: use gopls to format
      -- false if you want to use other formatter tool(e.g. efm, nulls)
      lsp_inlay_hints = {
        enable = true,
        -- Only show inlay hints for the current line
        only_current_line = true,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show variable name before type hints with the inlay hints or not
        -- default: false
        show_variable_name = true,
        -- prefix for parameter hints
        parameter_hints_prefix = " ",
        show_parameter_hints = true,
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 6,
        -- The color of the hints
        highlight = "Comment",
      },
      gopls_cmd = nil,          -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
      gopls_remote_auto = true, -- add -remote=auto to gopls
      gocoverage_sign = "█",
      sign_priority = 5,
      dap_debug = false,        -- set to false to disable dap
      dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
      -- false: do not use keymap in go/dap.lua.  you must define your own.
      dap_debug_gui = false,    -- set to true to enable dap gui, highly recommended
      dap_debug_vt = false,     -- set to true to enable dap virtual text
      build_tags = "",          -- set default build tags
      textobjects = false,      -- enable default text jobects through treesittter-text-objects
      test_runner = "go",       -- richgo, go test, richgo, dlv, ginkgo
      run_in_floaterm = false,  -- set to true to run in float window.
      -- float term recommended if you use richgo/ginkgo with terminal color
      luasnip = false,
    }
  end
}
