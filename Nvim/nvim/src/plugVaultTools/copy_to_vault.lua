local format = string.format

-- Configuración de colores y símbolos
local COLOR_RESET = "\27[0m"
local COLOR_RED = "\27[31m"
local COLOR_GREEN = "\27[32m"
local COLOR_YELLOW = "\27[33m"
local COLOR_BLUE = "\27[34m"
local SYM_CHECK = COLOR_GREEN .. "✓" .. COLOR_RESET
local SYM_CROSS = COLOR_RED .. "✗" .. COLOR_RESET
local SYM_INFO = COLOR_BLUE .. "ℹ" .. COLOR_RESET
local SYM_WARN = COLOR_YELLOW .. "!" .. COLOR_RESET

-- Configuración de rutas
local PluginList = "../plugins-for-the-vault.txt"
local VaultDir = "../plugVault/"
local LazyDir = "../../../../.local/share/nvim/lazy/"

-- Función para verificar la existencia de un comando
local function command_exists(cmd)
  local f = io.popen('command -v ' .. cmd .. ' 2> /dev/null')
  if not f then return false end
  local exists = f:read('*a') ~= ""
  f:close()
  return exists
end

local function print_header(title)
  print("\n" .. COLOR_BLUE .. "=== " .. title .. " ===" .. COLOR_RESET)
end

local function print_table(title, items, color, symbol)
  if #items > 0 then
    print("\n" .. color .. title .. COLOR_RESET)
    for _, item in ipairs(items) do
      print(format("  %s %s", symbol, item))
    end
  end
end

local function processDirs(plugins)
  local missingDirs = {}
  local addedDirs = {}
  local command_fcp = command_exists("fcp")
  local copy_command = command_fcp and "fcp" or "cp -r"

  print_header("COPY OPERATION")

  for _, pluginName in ipairs(plugins) do
    local vaultPath = VaultDir .. pluginName
    local lazyPath = LazyDir .. pluginName

    if io.open(vaultPath, "r") then
      print(format("  %s %s already exists in vault", SYM_INFO, pluginName))
    elseif io.open(lazyPath, "r") then
      local success = os.execute(format("%s %s %s", copy_command, lazyPath, vaultPath))
      if success then
        table.insert(addedDirs, lazyPath)
        print(format("  %s Copied %s", SYM_CHECK, pluginName))
      else
        table.insert(missingDirs, COLOR_RED .. "Failed to copy: " .. pluginName)
      end
    else
      table.insert(missingDirs, lazyPath)
    end
  end

  print_table("Missing directories:", missingDirs, COLOR_YELLOW, SYM_CROSS)
  print_table("Successfully added:", addedDirs, COLOR_GREEN, SYM_CHECK)
end

local function main()
  local function get_input(prompt)
    io.write(COLOR_BLUE .. prompt .. COLOR_RESET)
    return io.read("*l")
  end

  local function remove_plugins(data, dirname, path)
    print_header("REMOVE OPERATION")
    print(COLOR_YELLOW .. "WARNING: This will permanently delete directories!" .. COLOR_RESET)
    
    local confirm = get_input("Are you sure you want to proceed? (y/n): ")
    if confirm:lower() ~= 'y' then
      print(COLOR_RED .. "Operation cancelled" .. COLOR_RESET)
      return
    end

    local removed = {}
    local not_found = {}
    
    for _, pluginName in ipairs(data) do
      local PATH = path .. pluginName
      if io.open(PATH, "r") then
        os.execute(format("rm -rf %s", PATH))
        table.insert(removed, PATH)
        print(format("  %s Removed %s", SYM_CHECK, PATH))
      else
        table.insert(not_found, PATH)
        print(format("  %s Not found %s", SYM_CROSS, PATH))
      end
    end

    print_table("Successfully removed:", removed, COLOR_GREEN, SYM_CHECK)
    print_table("Not found:", not_found, COLOR_YELLOW, SYM_CROSS)
  end

  -- Verificar existencia de directorios
  if not io.open(VaultDir, "r") or not io.open(LazyDir, "r") or not io.open(PluginList, "r") then
    print(COLOR_RED .. "Error: Missing directory or file" .. COLOR_RESET)
    return
  end

  -- Leer lista de plugins
  local plugins = {}
  for line in io.lines(PluginList) do
    table.insert(plugins, line)
  end

  if #plugins == 0 then
    print(COLOR_RED .. "Error: No plugins found in the list" .. COLOR_RESET)
    return
  end

  -- Menú principal
  print(COLOR_BLUE .. "\nPlugin Manager Menu:" .. COLOR_RESET)
  local option
  repeat
    option = get_input("1. Copy to vault\n2. Purge Lazy folder\nEnter choice (1/2): ")
  until option == "1" or option == "2"

  if option == "1" then
    remove_plugins(plugins, "PlugVault", VaultDir)
    processDirs(plugins)
  elseif option == "2" then
    remove_plugins(plugins, "Lazy", LazyDir)
  end

  print(COLOR_GREEN .. "\nOperation completed!" .. COLOR_RESET)
end

main()

