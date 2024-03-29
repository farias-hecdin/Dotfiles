local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- nvim-lsp-extras
-- lsp-zero.nvim
-- nvim-lint

return {
  {
    url = "https://github.com/seblj/nvim-lsp-extras",
    event = {
      "BufReadPre",
      "BufNewFile"
    },
    config = function()
      require("nvim-lsp-extras").setup({
        signature = false,
        mouse_hover = false,
        lightbulb = false,
        treesitter_hover = {
          highlights = {
            ["|%S-|"] = "@text.reference",
            ["@%S+"] = "@parameter",
            ["^%s*(Parameters:)"] = "@text.title",
            ["^%s*(Return:)"] = "@text.title",
            ["^%s*(See also:)"] = "@text.title",
            ["{%S-}"] = "@parameter",
          },
        },
      })
    end
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
    config = false
  },
  {
    -- url = "https://github.com/arnevm123/nvim-lint.git",
    dir = D.plugin .. "nvim-lint",
    enabled = false,
    event = {"BufReadPre"},
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {}
      -- A autocmd to trigger linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", {clear = true})
      vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end
      })
    end
  }
}

