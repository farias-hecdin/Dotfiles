local D = {}

-- Path to the plugin-vault
D.plugin = "~/.config/nvim/src/plugVault/"

-- Path to $HOME
D.home = "/data/data/com.termux/files/home/"

-- Useful for disable plugins
D.notContainFiletype = function(extensions)
  local file = vim.fn.expand("%")
  local extension = file:match("^.+(%..+)$")

  for _, value in pairs(extensions) do
    if extension == "." .. value then
      return false
    end
  end
  return true
end

return D
