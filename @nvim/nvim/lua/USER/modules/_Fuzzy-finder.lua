local D = require("USER.dir")

return {
  {
    -- "ibhagwan/fzf-lua",
    dir = D.plugin .. "fzf-lua",
    keys = { "<leader>F" },
    cmd = "FzfLua",
    config = function()
      local actions = require "fzf-lua.actions"
      require("fzf-lua").setup({
        winopts = {
          height = 0.95,
          width = 0.95,
          preview = {
            layout = "horizontal"
          }
        }
      })
    end
  }
}
