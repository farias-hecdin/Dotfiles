local D = require("USER.utils.dir")

return {
  {
    -- "hrsh7th/cmp-nvim-lsp",
    dir = D.plugin .. "cmp-nvim-lsp",
    event = "InsertEnter"
  },
  {
    -- "hrsh7th/cmp-buffer",
    dir = D.plugin .. "cmp-buffer",
    event = "InsertEnter"
  },
  {
    -- "hrsh7th/cmp-cmdline",
    dir = D.plugin .. "cmp-cmdline",
    keys = ":"
  },
  {
    -- "hrsh7th/cmp-path",
    dir = D.plugin .. "cmp-path",
    event = "InsertEnter"
  },
  {
    -- "hrsh7th/cmp-vsnip",
    dir = D.plugin .. "cmp-vsnip",
    event = "InsertEnter",
  },
  {
    -- "hrsh7th/vim-vsnip",
    dir = D.plugin .. "vim-vsnip",
    event = "InsertEnter",
  },
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  },
  {
    -- "hrsh7th/nvim-cmp",
    dir = D.plugin .. "nvim-cmp",
    event = "InsertEnter",
    keys = { ":" },
    config = function()
      local cmp = require("cmp")
      local icons = require('USER.utils.icons').lspkind

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
        window = {
          documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
          },
          completion = {
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
          }
        },
        mapping = cmp.mapping.preset.insert({
          ["<Up>"]      = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}), -- previous suggestion
          ["<Down>"]    = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}), -- next suggestion
          ["<C-p>"]     = cmp.mapping.select_prev_item(), -- previous suggestions
          ["<C-n>"]     = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-k>"]     = cmp.mapping.scroll_docs(-4), -- scrolling documentation
          ["<C-j>"]     = cmp.mapping.scroll_docs(4), -- scrolling documentation
          ["<C-e>"]     = cmp.mapping.abort(), -- abort completion window
          ["<Esc>"]     = cmp.mapping.close(), -- close completion window
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-y>"]     = cmp.mapping.confirm({ select = true }), -- accept suggestions
          ["<CR>"]      = cmp.mapping.confirm({ select = false }), -- accept suggestions
          -- Active suggestions
          ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1
            if cmp.visible() then
              cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
              fallback()
            else
              cmp.complete()
            end
          end, {"i", "s"}),
        }),

        -- sources for autocompletion
        sources = cmp.config.sources({
          {
            name = "nvim_lsp", -- For lsp
            max_item_count = 20,
            priority = 1000
          },
          {
            name = "vsnip", -- For vsnip users
            max_item_count = 20,
            priority = 750
          },
          {
            name = "buffer", -- For text within current buffer
            max_item_count = 20,
            priority = 500
          },
          {
            name = "path", -- For file system paths
            max_item_count = 20,
            priority = 250
          },
        }),
        sorting = {
          comparators = {
            cmp.config.compare.exact,
            -- cmp.config.compare.score,
            cmp.config.compare.recently_used,
          }
        },
        -- configure icons
        formatting = {
          fields = { "abbr", "menu", "kind" },
          format = function(entry, vim_item)
            local vim_kind = vim_item.kind
            vim_item.kind = (icons[vim_kind] or "") .. " " .. vim_kind .. " "
            vim_item.dup = ({
              vsnip = 0,
              nvim_lsp = 0,
              nvim_lua = 0,
              buffer = 0,
            })[entry.source.name] or 0

            return vim_item
          end
        },
      })

      -- ":" cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {{ name = "path" }},
          {{ name = "cmdline", option = {ignore_cmds = {"Man", "!"}} }}
        )
      })
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
    end
  },
}

