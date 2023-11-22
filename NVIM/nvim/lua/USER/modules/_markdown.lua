local D = require("USER.modules.utils.dir")

return {
  {
    -- url = "https://github.com/antonk52/markdowny.nvim.git",
    dir = D.plugin .. "markdowny.nvim",
    keys = { "<C-i>", "<C-l>", "<C-b>" },
    ft = "markdown",
    config = function()
      require("markdowny").setup()
    end
  },
  {
    -- url = "https://github.com/whitestarrain/md-section-number.nvim.git",
    dir = D.plugin .. "md-section-number.nvim",
    ft = "markdown",
    config = function()
      require("md_section_number").setup({
        toc = {
          width = 40,
          position = "right",
          indent_space_number = 2,
          header_prefix = "• ",
        },
      })
    end
  },
  -- {
  --   dir = D.plugin .. "autolist.nvim",
  --   ft = "markdown",
  --   config = function()
  --     require("autolist").setup()
  --
  --     vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
  --     vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
  --     -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
  --     vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
  --     vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
  --     vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
  --     vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
  --     vim.keymap.set("n", "<leader>Ml", "<cmd>AutolistRecalculate<cr>")
  --
  --     -- cycle list types with dot-repeat
  --     vim.keymap.set("n", "<leader>Mn", require("autolist").cycle_next_dr, { expr = true })
  --     vim.keymap.set("n", "<leader>Mp", require("autolist").cycle_prev_dr, { expr = true })
  --
  --     -- if you don't want dot-repeat
  --     -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
  --     -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")
  --
  --     -- functions to recalculate list on edit
  --     vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
  --     vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
  --     vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
  --     vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
  --   end,
  -- },
}
