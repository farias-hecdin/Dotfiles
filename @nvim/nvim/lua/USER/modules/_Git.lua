local D = require("USER.dir")

return {
  {
    -- "lewis6991/gitsigns.nvim",
    dir = D.plugin .. "gitsigns.nvim",
    event = "InsertLeave",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "" },
          change = { text = "" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "" },
          untracked = { text = "" },
        },
      })
    end
  },
}
