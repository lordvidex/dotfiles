return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-telescope/telescope-dap.nvim',
    {
      'leoluz/nvim-dap-go',
      config = function()
        require 'dap-go'.setup()
      end
    }, -- TODO: add keymap and setup for go
  },
  config = function()
    local ok, dap = pcall(require, 'dap')
    if not ok then
      return
    end

    local telescope_ok, telescope = pcall(require, 'telescope')
    if telescope_ok then
      telescope.load_extension('dap')
    end

    local ndvt_ok, ndvt = pcall(require, 'nvim-dap-virtual-text')
    if ndvt_ok then
      ndvt.setup()
    end

    -- automatically install dap debuggers when needed
    local mvd_ok, mason_nvim_dap = pcall(require, 'mason-nvim-dap')
    if mvd_ok then
      mason_nvim_dap.setup({
        ensure_installed = { 'delve' },
        automatic_installation = true,
        handlers = {
          function(config)
            -- all sources with no handlers will get passed here
            -- Keep original functionality
            mason_nvim_dap.default_setup(config)
          end
        },
      })
    end

    -- setup whichkey shortcuts for debugger
    local whichkey_ok, whichkey = pcall(require, 'which-key')
    if whichkey_ok then
      whichkey.add({
        -- register with no prefix
        ["<F5>"] = { "<cmd>lua require('dap').continue()<CR>", "St[a]rt Debug" },
        ["<F9>"] = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
        ["<F10>"] = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
        ["<F11>"] = { "<cmd>lua require('dap').step_into()<CR>", "Step into" },
        ["<F12>"] = { "<cmd>lua require('dap').step_out()<CR>", "Step out" },
      })

      whichkey.add({
        -- register with <leader> prefix
        { "<leader>d",   group = "Debug" },
        { "<leader>db",  group = "BreakPoints" },
        { "<leader>dbb", "<cmd>lua require('dap').toggle_breakpoint()<CR>",                                              desc = "Create" },
        { "<leader>dbc", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",           desc = "Breakpoint Condition" },
        { "<leader>dbd", "<cmd>lua require('dap').clear_breakpoints()<CR>",                                              desc = "[D]elete all breakpoints" },
        { "<leader>dbm", "<cmd>lua require('dap').set_breakpoint({nil, nil, vim.fn.input('Log point message: ') })<CR>", desc = "Log Point Message" },
        { "<leader>df",  "<cmd>Telescope dap frames<CR>",                                                                desc = "Telescope DAP frames" },
        { "<leader>dj",  "<cmd>lua require('dap').down()<CR>",                                                           desc = "Down" },
        { "<leader>dk",  "<cmd>lua require('dap').up()<CR>",                                                             desc = "Up" },
        { "<leader>dl",  "<cmd>Telescope dap list_breakpoints<CR>",                                                      desc = "Telescope DAP Breakpoints" },
        { "<leader>dq",  "<cmd>lua require('dap').terminate()<CR>",                                                      desc = "[Q]uit debugger" },
        { "<leader>dr",  group = "Repl" },
        { "<leader>drl", "<cmd>lua require('dap').repl.run_last()<CR>",                                                  desc = "Run Last" },
        { "<leader>dro", "<cmd>lua require('dap').repl.open()<CR>",                                                      desc = "Open" },
        { "<leader>du",  group = "UI" },
        { "<leader>duf", "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>",  desc = "Float" },
        { "<leader>duh", "<cmd>lua require('dap.ui.widgets').hover()<CR>",                                               desc = "Hover" },
        { "<leader>dui", "<cmd>lua require('dapui').toggle()<CR>",                                                       desc = "Toggle UI" },
        { "<leader>dv",  "<cmd>Telescope dap variables<CR>",                                                             desc = "Telescope DAP variables" },
      })
    end

    local dapui_ok, dapui = pcall(require, 'dapui')
    if not dapui_ok then
      print('Warning: dapui not found')
    end

    if dapui_ok then
      dapui.setup()
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
    end
  end,
}
