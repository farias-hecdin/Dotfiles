local D = require("USER.modules.utils.dir")

return {
  -- * mini-splitjoin ---------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.splitjoin.git",
    dir = D.plugin .. "mini.splitjoin",
    keys = {
      {mode = "n", "gS", desc = "Split and join symbols"}
    },
    config = true
  },
  -- * mini-cursorword --------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.cursorword.git",
    dir = D.plugin .. "mini.cursorword",
    event = "InsertEnter",
    config = true
  },
  -- * mini-pairs -------------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.pairs.git",
    dir = D.plugin .. "mini.pairs",
    enabled = false,
    config = true
  },
  -- * mini-ai ----------------------------------------------------------------
  {
    -- url = "https://github.com/echasnovski/mini.ai.git",
    dir = D.plugin .. "mini.ai",
    event = "InsertEnter",
    config = true,
  }
}
