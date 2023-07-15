local D = require("USER.utils.dir")

return {
  {
    -- "phaazon/mind.nvim",
    dir = D.plugin .. "mind.nvim",
    cmd = "MindOpenMain",
    config = function()
      require("mind").setup()
      -- normal = {
      --   ["<tab>"] = "open_data",
      --   ["<s-tab>"] = "open_data_index",
      --   ["<cr>"] = "toggle_node",
      --   ["<s-cr>"] = "toggle_node",
      --   ["/"] = "select_path",
      --   ["$"] = "change_icon_menu",
      --   c = "add_inside_end_index",
      --   I = "add_inside_start",
      --   i = "add_inside_end",
      --   l = "copy_node_link",
      --   L = "copy_node_link_index",
      --   d = "delete",
      --   D = "delete_file",
      --   O = "add_above",
      --   o = "add_below",
      --   q = "quit",
      --   r = "rename",
      --   R = "change_icon",
      --   u = "make_url",
      --   x = "select",
      -- }
      -- selection = {
      --   ["<tab>"] = "open_data",
      --   ["<s-cr>"] = "toggle_node",
      --   ["/"] = "select_path",
      --   I = "move_inside_start",
      --   i = "move_inside_end",
      --   O = "move_above",
      --   o = "move_below",
      --   q = "quit",
      --   x = "select",
      -- }
    end
  },
}
