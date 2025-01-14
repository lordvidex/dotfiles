-- experimental, tried blink but not impressed
return {
  'saghen/blink.cmp',
  enabled = false,
  dependencies = 'rafamadriz/friendly-snippets',
  version = 'v0.8.2',
  opts = function(_, opts)
    opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
      default = { "lsp", "path", "snippets", "buffer", "luasnip" },
      providers = {
        lsp = {
          name = "lsp",
          enabled = true,
          module = "blink.cmp.sources.lsp",
          -- kind = "LSP",
          -- When linking markdown notes, I would get snippets and text in the
          -- suggestions, I want those to show only if there are no LSP
          -- suggestions
          fallbacks = { "snippets", "luasnip", "buffer" },
          score_offset = 90, -- the higher the number, the higher the priority
        },
        luasnip = {
          name = "luasnip",
          enabled = true,
          module = "blink.cmp.sources.luasnip",
          min_keyword_length = 2,
          fallbacks = { "snippets" },
          score_offset = 85, -- the higher the number, the higher the priority
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 3,
          -- When typing a path, I would get snippets and text in the
          -- suggestions, I want those to show only if there are no path
          -- suggestions
          fallbacks = { "snippets", "luasnip", "buffer" },
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end,
            show_hidden_files_by_default = true,
          },
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          min_keyword_length = 2,
        },
        snippets = {
          name = "snippets",
          enabled = true,
          module = "blink.cmp.sources.snippets",
          score_offset = 80, -- the higher the number, the higher the priority
        },
      }
    })
    opts.snippets = {
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then
          return require("luasnip").jumpable(filter.direction)
        end
        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    }
    -- The default preset used by lazyvim accepts completions with enter
    -- I don't like using enter because if on markdown and typing
    -- something, but you want to go to the line below, if you press enter,
    -- the completion will be accepted
    -- https://cmp.saghen.dev/configuration/keymap.html#default
    opts.keymap = {
      preset = "none",
      ["<C-j"] = { "select_next" },
      ["<Tab>"] = { function(cmp)
        if cmp.snippet_active() then
          return cmp.accept()
        else
          return cmp.select_and_accept()
        end
      end, 'snippet_forward', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ["<C-k>"] = { "select_prev" },
      ["<C-S-f>"] = { "scroll_documentation_up" },
      ["<C-f>"] = { "scroll_documentation_down" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
    }
  end
}
