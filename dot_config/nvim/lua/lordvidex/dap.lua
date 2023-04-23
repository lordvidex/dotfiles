local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

require('telescope').load_extension('dap') -- view dap windows from telescope
require('nvim-dap-virtual-text').setup()

-- automatically install dap debuggers when needed
require('mason-nvim-dap').setup({
  ensure_installed = { 'delve' },
  automatic_installation = true,
  handlers = {
    function(config)
      -- all sources with no handlers will get passed here
      -- Keep original functionality
      require('mason-nvim-dap').default_setup(config)
    end
  },
})

-- setup whichkey shortcuts for debugger
local whichkey = require('which-key')

whichkey.register({
  -- register with no prefix
  ["<F5>"] = { "<cmd>lua require('dap').continue()<CR>", "St[a]rt Debug" },
  ["<F9>"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
  ["<F10>"] = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
  ["<F11>"] = { "<cmd>lua require('dap').step_into()<CR>", "Step into" },
  ["<F12>"] = { "<cmd>lua require('dap').step_out()<CR>", "Step out" },
})

whichkey.register({
  -- register with <leader> prefix
  d = {
    name = "Debug",
    j = { "<cmd>lua require('dap').down()<CR>", "Down" },
    k = { "<cmd>lua require('dap').up()<CR>", "Up" },
    u = {
      name = "UI",
      h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
      f = { "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Float" },
      i = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle UI" },
    },
    r = {
      name = "Repl",
      o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
      l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
    },
    b = {
      name = "BreakPoints",
      c = {
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        "Breakpoint Condition",
      },
      d = { "<cmd>lua require('dap').clear_breakpoints()<CR>", "[D]elete all breakpoints" },
      m = {
        "<cmd>lua require('dap').set_breakpoint({nil, nil, vim.fn.input('Log point message: ') })<CR>",
        "Log Point Message",
      },
      b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
    },
    q = { "<cmd>lua require('dap').terminate()<CR>", "[Q]uit debugger" },
    f = { "<cmd>Telescope dap frames<CR>", "Telescope DAP frames" },
    l = { "<cmd>Telescope dap list_breakpoints<CR>", "Telescope DAP Breakpoints" },
    v = { "<cmd>Telescope dap variables<CR>", "Telescope DAP variables" },
  }
}, { prefix = "<leader>" })

-- setup dap listeners to close dapui after and before debugging
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end

dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end
