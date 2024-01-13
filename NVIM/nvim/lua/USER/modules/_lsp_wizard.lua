local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- lsp-zero.nvim
-- nvim-lint

return {
 {
   'VonHeikemen/lsp-zero.nvim',
   branch = 'v3.x',
   event = { "BufReadPre" },
   config = function()
     local lsp_zero = require('lsp-zero')
     lsp_zero.extend_lspconfig()
     lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      local function enable_lsp(lang, servers)
        local path = "USER.modules.lsp."
        require(path .. lang).lsp(servers)
      end

      enable_lsp("bash", { "bashls" })
      enable_lsp("css", { "cssls" })
      enable_lsp("go", { "gopls" })
      enable_lsp("html", { "emmet_ls" })
      enable_lsp("java", { "jdtls" })
      enable_lsp("javascript", { "astro", "jsonls", "svelte", "tsserver" })
      enable_lsp("lua", { "lua_ls" })
      enable_lsp("php", { "phpactor" })
      enable_lsp("python", { "pyright" })
    end
  },
  {
    -- url = "https://github.com/arnevm123/nvim-lint.git",
    dir = D.plugin .. "nvim-lint",
    enabled = false,
    -- event = { "BufReadPre" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- java = {'checkstyle'},
        -- javascript = {'eslint_d'},
        -- javascriptreact = {'eslint_d'},
      }
      -- A autocmd to trigger linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end
  },
}
