local D = require("USER.modules.utils.dir")

return {
  { "nvim-lua/plenary.nvim" },
  {
    -- "nvim-tree/nvim-web-devicons",
    dir = D.plugin .. "nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({
        override_by_filename = {
          ["astro"]      = {icon = "", color = "#F9A825", name = "Astro"},
          ["prettierrc"] = {icon = "", color = "#AAAAAA", name = "prettierrc"}
        }
      })
    end
  },
}
