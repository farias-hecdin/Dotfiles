local format = string.format

local PluginList = "../plugins-for-the-vault.txt"
local VaultDir = "../plugVault/"
local LazyDir = "../../../../.local/share/nvim/lazy/"

-- Function to check if a command exists
local function command_exists(cmd)
  local f = io.popen('command -v ' .. cmd)
  if not f then error("Error to execute command") end
  local output = f:read('*all')
  f:close()
  return output ~= ""
end

local function processDirs(plugins)
  local missingDirs = {}
  local addedDirs = {}
  local command_fcp = command_exists("fcp")

  print('\n** OPERATION: copy\n')
  for _, pluginName in ipairs(plugins) do
    local vaultPath = VaultDir .. pluginName
    local lazyPath = LazyDir .. pluginName

    if io.open(vaultPath, "r") then
      print(format("%s already exists in %s", pluginName, VaultDir))
    elseif io.open(lazyPath, "r") then
      if command_fcp then
        os.execute(format("fcp %s %s", lazyPath, vaultPath))
      else
        os.execute(format("cp -r %s %s", lazyPath, vaultPath))
      end
      table.insert(addedDirs, lazyPath)
    else
      table.insert(missingDirs, lazyPath)
    end
  end

  if #missingDirs > 0 then
    print("\nMissing dirs:\n " .. table.concat(missingDirs, "\n "))
  end
  if #addedDirs > 0 then
    print("\nAdded dirs:\n " .. table.concat(addedDirs, "\n "))
  end
end

local function main()
  local get_input = function(prompt)
    io.write(prompt)
    return io.read()
  end

  local remove_plugins = function(data, dirname, path)
    print('\n** OPERATION: remove\n')
    print('Removed dirs: ' .. dirname)

    for _, pluginName in ipairs(data) do
      local PATH = path .. pluginName
      print(format(" " .. PATH))
      if io.open(path, "r") then
        os.execute(format("rm -rf %s", PATH))
      end
    end
  end

  if not io.open(VaultDir, "r") or not io.open(LazyDir, "r") or
    not io.open(PluginList, "r") then
    print("Error: Directory or file does not exist.")
    return
  end

  local plugins = {}
  for line in io.lines(PluginList) do
    table.insert(plugins, line)
  end

  local option = get_input('(1) Copy to vault or (2) purge Lazy folder?: ')
  if option == "1" then
    remove_plugins(plugins, "PlugVault", VaultDir)
    processDirs(plugins)
  elseif option == "2" then
    remove_plugins(plugins, "Lazy", LazyDir)
  end
end

main()
