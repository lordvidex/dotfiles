local M = {}
-- Enable autosave for the current buffer
local function autowrite()
  vim.o.autowrite = true
  vim.cmd [[
  augroup AutoWrite
    autocmd!
    autocmd BufLeave,FocusLost,InsertLeave,TextChanged,CursorHold * if &modifiable | silent write | endif
  augroup END

  ]]
end

local engines = {}
local current_engine = 'codeium'
local lhs = '<C-l>'

local function complete()
  if current_engine == nil then
    vim.notify('no engine selected')
  else
    return engines[current_engine]
  end
end

local function setup_engines()
  -- check for copilot
  if vim.fn.exists('*copilot#Accept') then
    -- set the key as copilot and the value as the callback function
    engines['copilot'] = function()
      local copilot_keys = vim.fn['copilot#Accept']()
      if copilot_keys ~= '' and type(copilot_keys) == 'string' then
        vim.api.nvim_feedkeys(copilot_keys, 'i', true)
      end
    end
  end
  -- check for codeium
  if vim.fn.exists('*codeium#Accept') then
    engines['codeium'] = function()
      local delete_range = vim.fn['codeium#Accept']()
      local keys = vim.fn['codeium#CompletionText']()
      if keys ~= '' and type(keys) == 'string' then
        vim.api.nvim_feedkeys(delete_range .. keys, 'i', true)
      end
    end
  end

  -- register neovim commands
  vim.api.nvim_create_user_command('Complete', function(opts)
      args = vim.fn.split(opts.fargs[1], ' ')
      local command = args[1]
      if command == 'current' then
        if current_engine == nil then
          vim.notify('No engine set')
        else
          vim.notify('Current engine: ' .. current_engine)
        end
      elseif command == 'select' then
        local engine = args[2]
        if engines[engine] then
          current_engine = engine
          vim.keymap.set('i', lhs, engines[engine], { silent = true, expr = true })
          vim.notify('Complete engine set to ' .. engine)
        end
      end
    end,
    {
      nargs = 1,
      complete = function(_, CmdLine, _)
        local parts = vim.fn.split(CmdLine, ' ')
        local pos = #parts
        if pos == 1 then
          return { 'current', 'select' }
        elseif pos == 2 then
          return vim.tbl_keys(engines)
        else
          return nil
        end
      end,
    }
  )
  vim.keymap.set('i', lhs, engines[current_engine], { silent = true, expr = true })
end
M.autowrite = autowrite
M.setup_after = setup_engines

return M
