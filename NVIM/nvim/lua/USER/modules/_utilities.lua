local D = require("USER.modules.utils.dir")
local vim = vim

-- SUMMARY
-- * plenary.nvim
-- * mini.icons
-- * code_runner
-- * url-open
-- * flatten.nvim
-- * messages.nvim

return {
  {
    url = "https://github.com/nvim-lua/plenary.nvim.git",
    -- dir = D.plugin .. "plenary.nvim",
  },
  {
    url = 'https://github.com/echasnovski/mini.icons.git',
    -- dir = D.plugin .. "mini.icons",
    lazy = false,
    config = function ()
      require('mini.icons').setup()
    end
  },
  -- {
  --   -- "https://github.com/sontungexpt/url-open.git",
  --   -- dir = D.plugin .. "url-open",
  --   cmd = "URLOpenUnderCursor",
  --   config = function()
  --     require("url-open").setup({
  --       extra_patterns = {
  --         {
  --           pattern = '"(github%.com/[^"]+)"',
  --           prefix = "https://pkg.go.dev/",
  --         },
  --       },
  --     })
  --   end
  -- },
  {
    url = "https://github.com/CRAG666/code_runner.nvim.git",
    -- dir = D.plugin .. "code_runner.nvim",
    cmd = {"RunCode", "RunFile", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects"},
    opts =  {
      term = {size = 45},
      filetype = {
        go = "go run",
        java = {"cd $dir &&", "javac $fileName &&", "java $fileNameWithoutExt &&", "rm -rf *.class"},
        lua = "luajit",
        nim = "nim compile --run -d:release",
        php = "php",
        python = "python3 -u",
        sh = "bash",
        typescript = "deno run",
      }
    }
  },
  {
    url = "https://github.com/willothy/flatten.nvim.git",
    -- dir = D.plugin .. "flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001
  },
  {
    url = "https://github.com/AckslD/messages.nvim.git",
    -- dir = D.plugin .. "messages.nvim",
    cmd = "Messages",
    config = function()
      require('messages').setup({
        command_name = 'Messages',
        prepare_buffer = function(opts)
          local buf = vim.api.nvim_create_buf(false, true)
          return vim.api.nvim_open_win(buf, true, opts)
        end,
        buffer_opts = function(lines)
          local gheight = vim.api.nvim_list_uis()[1].height
          local gwidth = vim.api.nvim_list_uis()[1].width
          return {
            relative = 'editor',
            width = gwidth - 2,
            height = gheight * 0.5,
            anchor = 'SW',
            row = gheight - 1,
            col = 0,
            style = 'minimal',
            border = 'rounded',
            zindex = 1,
          }
        end,
        post_open_float = function(winnr)
        end
      })
    end
  },
}
