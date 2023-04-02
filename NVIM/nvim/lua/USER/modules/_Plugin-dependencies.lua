return {
  {
    "nvim-lua/plenary.nvim",
    pin = true,
  },
  {
    -- "kyazdani42/nvim-web-devicons",
    dir = "~/.config/nvim/src/plugins/" .. "__nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup()
    end
  },
}
