require('flutter-tools').setup {
  lsp = {
    color = {
      enabled = true,
      background = true,
    },
    on_attach = require("lordvidex.lsp.handlers").on_attach,
    capabilities = require("lordvidex.lsp.handlers").capabilities,
  },
  fvm = true,
  flutter_path = "/Users/lordvidex/Developer/flutter/bin/flutter",
  widget_guides = {
    enabled = true,
    debug = true,
  },
  decorations = {
    statusline = { device = true, app_version = true },
  },
  debugger = {
    run_via_dap = true,
    enabled = true,
    register_configuration = function(_)
      print('dart configuration registered')
      require('dap').configurations.dart = {}
      require('dap.ext.vscode').load_launchjs()
    end
  },
  outline = {
    auto_open = true,
  },
}

require('telescope').load_extension('flutter')
