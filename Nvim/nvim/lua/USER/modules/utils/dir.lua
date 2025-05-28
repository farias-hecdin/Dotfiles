local D = {}

-- Path to $HOME
D.home = "/data/data/com.termux/files/home/"

-- Path to the plugin-vault
D.plugin = "~/.config/nvim/src/plugVault/"


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


D.pluginExists = function(plugin)
  local request, _ = pcall(require, plugin)
  if request then
    return true
  end
  return false
end

return D
