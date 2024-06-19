local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- * Colorformat
-- * Colorker
-- * markdown.nvim
-- * markdowny.nvim
-- * nvim-jdtls
-- * nvim-px-to-rem

return {
  {
    url = "https://github.com/alaviss/nim.nvim.git",
    ft = "nim",
    config = function()
      local aug = vim.api.nvim_create_augroup("NimRestartKeybinds", { clear = true })
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "nim",
        group = aug,
        desc = "Assign keybind to reset lang server attached to this buffer.",
        callback = function()
          vim.keymap.set("n", "<Leader>(", "<Cmd>LspStart<CR>", { buffer = 0, silent = true })
          vim.keymap.set("n", "<Leader>)", "<Cmd>LspRestart<CR>", { buffer = 0, silent = true })
        end,
      })
    end,
  },
  {
    url = "https://github.com/mfussenegger/nvim-jdtls.git",
    -- dir = D.plugin .. "nvim-jdtls",
    ft = "java",
    config = true
  },
  {
    url = "https://github.com/farias-hecdin/CSSVarHighlight.git",
    ft = "css",
    dependencies = {
      "echasnovski/mini.hipatterns",
      "farias-hecdin/CSSPluginHelpers",
    },
    config = function()
      require('CSSVarHighlight').setup({
        variable_pattern = "%-%-[-_%w]*co%-[-_%w]*",
      })
    end,
  },
  {
    url = "https://github.com/farias-hecdin/CSSVarViewer.git",
    ft = "css",
    dependencies = {
      "farias-hecdin/CSSPluginHelpers",
    },
    config = true
  },
  {
    url = "https://github.com/farias-hecdin/CSSColorConverter.git",
    ft = "css",
    dependencies = {
      "farias-hecdin/CSSPluginHelpers",
    },
    config = true
  },
  {
    -- url = "https://github.com/jsongerber/nvim-px-to-rem.git",
    dir = D.plugin .. "nvim-px-to-rem",
    cmd = {
      "PxToRemCursor",
      "PxToRemLine"
    },
    ft = "css",
    opts = {
      add_cmp_source = false,
      disable_keymaps = true
    }
  },
  {
    -- url = "https://github.com/antonk52/markdowny.nvim.git",
    dir = D.plugin .. "markdowny.nvim",
    keys = {"<C-i>", "<C-l>", "<C-n>"},
    ft = "markdown",
    config = true
  },
  {
    -- url = "https://github.com/tadmccorkle/markdown.nvim.git",
    dir = D.plugin .. "markdown.nvim",
    ft = "markdown",
    opts = {
      toc = {
        omit_heading = "toc omit heading",
        omit_section = "toc omit section",
      },
    }
  },
}
