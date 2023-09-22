local D = require("USER.utils.dir")

return {
  { "nvim-lua/plenary.nvim" },
  {
    -- "nvim-tree/nvim-web-devicons",
    dir = D.plugin .. "nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({
        override_by_filename = {
          ["astro"] = {
            icon = "",
            name = "Astro"
          }
        }
      })
    end
  },
}
