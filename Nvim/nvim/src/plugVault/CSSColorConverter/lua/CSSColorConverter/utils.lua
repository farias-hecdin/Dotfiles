local M = {}

--- To round a number to a specified number of decimal places
M.round = function(number, decimals)
  local power = 10 ^ decimals
  return math.floor(number * power + 0.5) / power
end

--- To read a file and return its content
local function read_file(file)
  local fd = assert(io.open(file, "r"))
  local data = fd:read("*a")
  fd:close()
  return data
end

-- To read a JSON file and return its content as a Lua table
M.read_json = function()
  local fd = read_file(vim.fn.expand('~/.local/share/nvim/colorformat/colornames.json'))
  return vim.json.decode(fd)
end

--- To download a file from a specified URL
-- thanks to: https://www.reddit.com/r/neovim/comments/pa4yle/help_with_async_in_lua/
M.download_file = function(url, file, name)
  local plugname = "[CSSColorConverter] "

  -- Try to load the 'plenary' plugin.
  local plugin_ok, _ = pcall(require, "plenary")
  if not plugin_ok then
    vim.print(plugname .. "The 'plenary' plugin was not found.")
    return
  end

  local Job = require('plenary.job')
  Job:new({
    command = 'curl',
    args = { '-s', url, '-o', file },
    on_start = function()
      vim.print(plugname .. 'Downloading ' .. name .. '...')
    end,
    on_exit = function(_, exit_code)
      local status = plugname .. "Success!"
      if exit_code ~= 0 then
        status = plugname .. "Error!"
      end
      vim.notify(status, vim.log.levels.INFO)
    end,
  }):start()
end

return M
