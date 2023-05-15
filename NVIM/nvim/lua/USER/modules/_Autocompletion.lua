local D = require("USER.dir")

return {
  {
    -- "hrsh7th/cmp-buffer",
    dir = D.plugin .. "cmp-buffer",
    event = "InsertEnter"
  },
  {
    -- "hrsh7th/cmp-nvim-lsp",
    dir = D.plugin .. "cmp-nvim-lsp",
    event = "InsertEnter"
  },
  {
    -- "hrsh7th/cmp-path",
    dir = D.plugin .. "cmp-path",
    event = "InsertEnter"
  },
  {
    -- "saadparwaiz1/cmp_luasnip",
    dir = D.plugin .. "cmp_luasnip",
    event = "InsertEnter"
  },
  {
    -- "hrsh7th/cmp-cmdline",
    dir = D.plugin .. "cmp-cmdline",
    keys = ":"
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    keys = { ":" },
    dependencies = {
      "hrsh7th/cmp-nvim-lua",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
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
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}), -- previous suggestion
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}), -- next suggestion
          ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestions
          ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- scrolling documentation
          ["<C-d>"] = cmp.mapping.scroll_docs(4), -- scrolling documentation
          ["<C-e>"] = cmp.mapping.abort(), -- abort completion window
          ["<Esc>"] = cmp.mapping.close(), -- close completion window
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- accept suggestions
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- accept suggestions
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
          -- Luasnip placeholder (next)
          ['<C-f>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, {'i', 's'}),
          -- Luasnip placeholder (back)
          ['<C-b>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {'i', 's'}),
        }),

        -- sources for autocompletion
        sources = cmp.config.sources({
          {
            name = "path", -- For file system paths
            max_item_count = 5,
          },
          {
            name = "nvim_lsp", -- For lsp
            max_item_count = 5,
          },
          {
            name = "buffer", -- For text within current buffer
            max_item_count = 5,
          },
          {
            name = "luasnip", -- For luasnip users
            max_item_count = 5,
          },
        }),
        -- configure icons
        formatting = {
          fields = { "menu","abbr", "kind" },
          format = function(entry, item)
            local menu_icon = {
              buffer = " ",
              cmdline = " ",
              luasnip = " ",
              nvim_lsp = " ",
              path = " ",
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
      })

      -- ":" cmdline setup.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          {{
            name = "path"
          }},
          {{
            name = "cmdline",
            option = { ignore_cmds = {"Man", "!"} }
          }}
        )
      })
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
    end
  },
}
