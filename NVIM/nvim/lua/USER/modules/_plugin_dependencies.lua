local D = require("USER.modules.utils.dir")

-- SUMMARY
-- plenary.nvim
-- nvim-web-devicons

return {
  {
    -- url = "https://github.com/nvim-lua/plenary.nvim.git",
    dir = D.plugin .. "plenary.nvim",
  },
  {
    -- url = "https://github.com/nvim-tree/nvim-web-devicons.git",
    dir = D.plugin .. "nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({
        override_by_filename = {
          ["astro"] = {
            icon = "",
            color = "#F9A825",
            name = "astro"
          },
          ["test.md"] = {
            icon = "",
            color = "#CBCB41",
            name = "test"
          },
          ["prettierrc"] = {
            icon = "",
            color = "#AAAAAA",
            name = "prettierrc"
          }
        }
      })
    end
  },
}
