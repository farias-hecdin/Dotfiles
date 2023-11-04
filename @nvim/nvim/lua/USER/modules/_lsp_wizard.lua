local D = require("USER.modules.utils.dir")
local A = "USER.modules.lsp."

return {
 {
   'VonHeikemen/lsp-zero.nvim',
   branch = 'v3.x',
   event = { "BufReadPre" },
   dependencies = {
     -- { 'mfussenegger/nvim-jdtls' }, -- to java
   },
   config = function()
     local lsp_zero = require('lsp-zero')
     lsp_zero.extend_lspconfig()
     lsp_zero.on_attach(function(client, bufnr)
       -- see :help lsp-zero-keybindings
       -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      -- LSP enabled ------------------------------------------------

      require(A .. "bash").lsp({"bashls"})
      require(A .. "css").lsp({"cssls"})
      require(A .. "go").lsp({"gopls"})
      require(A .. "html").lsp({"emmet_ls"})
      -- require(A .. "java").lsp({"jdtls"})
      require(A .. "javascript").lsp({"astro", "jsonls", "svelte", "tsserver"})
      require(A .. "lua").lsp({"lua_ls"})
      require(A .. "php").lsp({"phpactor"})
      -- require(A .. "python").lsp({"pyright"})

    end
  },
  {
    -- "arnevm123/nvim-lint",
    -- commit = "6ee074c",
    dir = D.plugin .. "nvim-lint",
     event = { "BufReadPre" },
     config = function()
       local lint = require("lint")
       lint.linters_by_ft = {
         java = {'checkstyle'},
         javascript = {'eslint_d'},
         javascriptreact = {'eslint_d'},
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
