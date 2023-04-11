return {
  {
    -- "samjwill/nvim-unception"
    dir = "~/.config/nvim/src/plugins/" .. "nvim-unception",
    event = "InsertEnter",
    init = function()
      -- Optional settings go here!
      -- e.g.) vim.g.unception_open_buffer_in_new_tab = true
    end
  },
  {
    -- "jbyuki/quickmath.nvim",
    dir = "~/.config/nvim/src/plugins/" .. "quickmath-nvim",
    cmd = { "Quickmath", "QuickmathNow" },
  },
}
