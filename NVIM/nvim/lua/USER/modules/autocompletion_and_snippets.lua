local D = require("USER.modules.utils.dir")

-- SUMMARY
-- * cmp-buffer
-- * cmp-cmdline
-- * cmp-nvim-lsp
-- * cmp-path
-- * cmp-vsnip
-- * nvim-cmp
-- * vim-vsnip

return {
  {
    -- url = "https://github.com/hrsh7th/cmp-cmdline.git",
    dir = D.plugin .. "cmp-cmdline",
    keys = {mode = "n", ":", desc = "Command mode"}
  },
  {
    -- url = "https://github.com/hrsh7th/cmp-path.git",
    dir = D.plugin .. "cmp-path",
    event = "InsertEnter",
    keys = {mode = "n", ":", desc = "Command mode"}
  },
  {
    -- url = "https://github.com/hrsh7th/cmp-buffer.git",
    dir = D.plugin .. "cmp-buffer",
    event = "InsertEnter"
  },
  {
    -- url = "https://github.com/hrsh7th/cmp-nvim-lsp.git",
    dir = D.plugin .. "cmp-nvim-lsp",
    event = "InsertEnter"
  },
  {
    -- url = "https://github.com/hrsh7th/cmp-vsnip.git",
    dir = D.plugin .. "cmp-vsnip",
    event = "InsertEnter"
  },
  {
    -- url = "https://github.com/hrsh7th/vim-vsnip.git",
    dir = D.plugin .. "vim-vsnip",
    event = "InsertEnter"
  },
  {
    "https://github.com/hrsh7th/nvim-cmp.git",
    event = "InsertEnter",
    keys = {mode = "n", ":", desc = "Command mode"},
    config = function()
      local icons = require("USER.modules.utils.misc.icons").lspkind
      local cmp = require("cmp")
      -- local lsp_zero = require('lsp-zero')
      -- lsp_zero.extend_cmp()

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end
        },
        window = {
          documentation = {
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None"
          },
          completion = {
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None"
          }
        },
        mapping = cmp.mapping.preset.insert({
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), {"i", "c"}), -- previous suggestion
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), {"i", "c"}), -- next suggestion
          ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestions
          ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-k>"] = cmp.mapping.scroll_docs(-4), -- scrolling documentation
          ["<C-j>"] = cmp.mapping.scroll_docs(4), -- scrolling documentation
          ["<C-e>"] = cmp.mapping.abort(), -- abort completion window
          ["<Esc>"] = cmp.mapping.close(), -- close completion window
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<CR>"] = cmp.mapping.confirm({select = false}), -- accept suggestions
          ["<C-y>"] = cmp.mapping.confirm({select = true}), -- accept suggestions
          ["<Tab>"] = cmp.mapping(function(fallback) -- Active suggestions
            local col = vim.fn.col(".") - 1
            if cmp.visible() then
              cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
              fallback()
            else
              cmp.complete()
            end
          end,
            {"i", "s"})
        }),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            max_item_count = 9,
            keyword_length = 2,
            priority = 100
          },
          {
            name = "vsnip",
            max_item_count = 9,
            keyword_length = 2,
            priority = 50
          },
          {
            name = "buffer",
            max_item_count = 5,
            keyword_length = 2,
            priority = 10
          },
          {
            name = "path",
            max_item_count = 9,
            keyword_length = 2,
            priority = 50
          }
        }),
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
          }
        },
        formatting = {
          fields = {"abbr", "menu", "kind"},
          format = function(entry, vim_item)
            local vim_kind = vim_item.kind
            vim_item.kind = (icons[vim_kind] or "") .. " " .. vim_kind .. " "
            vim_item.dup = ({vsnip = 0, nvim_lsp = 0, nvim_lua = 0})[entry.source.name] or 0
            return vim_item
          end
        }
      })

      -- ":" cmdline setup ----------------------------------------------------
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          {name = "path"},
          {name = "buffer"},
          {name = "cmdline", option = {ignore_cmds = {"Man", "!"}}}
        })
      })
      vim.opt.completeopt = {"menu", "menuone", "noselect"}
    end
  }
}
