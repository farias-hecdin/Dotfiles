local D = require("USER.modules.utils.dir")

return {
  {
    -- url = "https://github.com/folke/which-key.nvim.git",
    dir = D.plugin .. "which-key.nvim",
    keys = { { "<leader>" } },
    config = function()
      -- Register -------------------------------------------------------------
      local which_key = require("which-key")
      which_key.register(
        {
          ["z"] = { name = "Fold" },
          ["gz"] = { name = "Surround" },
          ["gd"] = { name = "LSP" },
          ["<leader>."] = { name = "Move" },
          ["<leader>C"] = { name = "Cmp" },
          ["<leader>f"] = { name = "Fuzzy Finder" },
          ["<leader>g"] = { name = "Git" },
          ["<leader>M"] = { name = "Markdown" },
          ["<leader>T"] = { name = "Treesitter" },
          ["<leader>b"] = { name = "Buffer" },
          ["<leader>e"] = { name = "Explorer" },
          ["<leader>F"] = { name = "File" },
          ["<leader>F!"] = { name = "Forced" },
          ["<leader>l"] = { name = "LSP" },
          ["<leader>m"] = { name = "Select/Marks" },
          ["<leader>n"] = { name = "Number" },
          ["<leader>p"] = { name = "Paste" },
          ["<leader>s"] = { name = "Split/Window" },
          ["<leader>t"] = { name = "Tabs" },
          ["<leader>x"] = { name = "Sessions" },
          ["<leader>xs"] = { name = "Sessions: save" },
          ["<leader>xd"] = { name = "Sessions: delete" },
          ["<leader>w"] = { name = "Wrap" },
        },
        { mode = "n" }
      )

      which_key.register(
        {
          ["<leader>."] = { name = "Tabs/move" },
          ["<leader>l"] = { name = "Letter" },
          ["<leader>m"] = { name = "Select" },
        },
        { mode = "v" }
      )

      -- Setup ----------------------------------------------------------------
      require("which-key").setup({
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
    end
  }
}
