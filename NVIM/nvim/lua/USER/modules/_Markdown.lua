local D = require("USER.dir")

return {
  {
    -- "AntonVanAssche/md-headers.nvim",
    dir = D.plugin .. "md-headers.nvim",
    ft = "markdown",
    config = function()
      require("md-headers").setup()
    end
  },
  {
    -- "antonk52/markdowny.nvim",
    dir = D.plugin .. "markdowny.nvim",
    keys = { "<C-i>", "<C-l>", "<C-b>" },
    ft = "markdown",
    config = function()
      require('markdowny').setup()
    end
  },
  {
    "gaoDean/autolist.nvim",
    -- dir = D.plugin .. "autolist.nvim",
    ft = "markdown",
    config = function()
      local autolist = require("autolist")
      autolist.setup()
      -- autolist.create_mapping_hook("i", "<CR>", autolist.new)
      autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
      -- autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
      autolist.create_mapping_hook("n", "o", autolist.new)
      -- autolist.create_mapping_hook("n", "O", autolist.new_before)
      autolist.create_mapping_hook("n", ">>", autolist.indent)
      autolist.create_mapping_hook("n", "<<", autolist.indent)
      autolist.create_mapping_hook("n", "<C-R>", autolist.force_recalculate)
      autolist.create_mapping_hook("n", "<C-X>", autolist.invert_entry, "")
      vim.api.nvim_create_autocmd("TextChanged", {
        pattern = "*",
        callback = function()
          vim.cmd.normal({ autolist.force_recalculate(nil, nil), bang = false })
        end
      })
    end,
  },
}
