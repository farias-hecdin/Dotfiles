local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- which-key.nvim

return {
  {
    -- url = "https://github.com/folke/which-key.nvim.git",
    dir = D.plugin .. "which-key.nvim",
    event = "InsertEnter",
    keys = { { "<leader>", mode = { 'n', 'v'} } },
    config = function()
      -- Enable Mini.plugins with <leader> key --------------------------------
      require('mini.extra').setup()

      -- Which-key ------------------------------------------------------------
      local which_key = require("which-key")

      which_key.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = false,
            suggestions = 20,
          },
        },
        operators = { gc = "Comments" },
        icons = {
          breadcrumb = "» ",
          separator = " ",
          group = "[+] ",
        },
        popup_mappings = {
          scroll_down = "<C-Down>",
          scroll_up = "<C-Up>",
        },
        window = {
          border = "rounded",
          position = "bottom",
          margin = { 1, 2, 1, 2 },
          padding = { 1, 1, 1, 1 },
          winblend = 0
        },
        layout = {
          height = { min = 5, max = 25 },
          width = { min = 25, max = 50 },
          spacing = 5,
          align = "left",
        },
      })
      -- Register
      which_key.register({
        ["<leader>."]  = { name = "Move" },
        ["<leader>C"]  = { name = "Cmp" },
        ["<leader>F!"] = { name = "Forced" },
        ["<leader>M"]  = { name = "Markdown" },
        ["<leader>T"]  = { name = "Treesitter" },
        ["<leader>b"]  = { name = "Buffer" },
        ["<leader>c"]  = { name = "ColorCommander" },
        ["<leader>e"]  = { name = "Explorer" },
        ["<leader>f"]  = { name = "Fuzzy Finder" },
        ["<leader>g"]  = { name = "Git" },
        ["<leader>l"]  = { name = "LSP" },
        ["<leader>m"]  = { name = "Select/Marks" },
        ["<leader>n"]  = { name = "Number" },
        ["<leader>p"]  = { name = "Paste" },
        ["<leader>s"]  = { name = "Split/Window" },
        ["<leader>t"]  = { name = "Tabs" },
        ["<leader>w"]  = { name = "Wrap" },
        ["<leaer>F"]   = { name = "File" },
        ["gd"]         = { name = "LSP" },
        ["gz"]         = { name = "Surround" },
        ["z"]          = { name = "Fold" },
      },
        { mode = "n" })

      which_key.register({
        ["<leader>."] = { name = "Tabs/move" },
        ["<leader>l"] = { name = "Letter" },
        ["<leader>m"] = { name = "Select" },
      },
        { mode = "v" })
    end
  }
}
