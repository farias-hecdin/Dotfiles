return {
  {
    "ibhagwan/fzf-lua",
    keys = { "<leader>F" },
    cmd = "FzfLua",
    config = function()
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
