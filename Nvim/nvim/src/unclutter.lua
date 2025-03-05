-- MIT License Copyright (c) 2023 Hecdin Farias
-- This script removes unwanted files and folders from the Vault folder.

-- Configuración de estilos visuales
local COLOR_RESET = "\27[0m"
local COLOR_RED = "\27[31m"
local COLOR_GREEN = "\27[32m"
local COLOR_YELLOW = "\27[33m"
local COLOR_BLUE = "\27[34m"
local COLOR_GRAY = "\27[37m"
local SYM_CHECK = COLOR_GREEN .. "✓" .. COLOR_RESET
local SYM_CROSS = COLOR_RED .. "✗" .. COLOR_RESET
local SYM_WARN = COLOR_YELLOW .. "⚠" .. COLOR_RESET
local BOLD = "\27[1m"
local UNBOLD = "\27[22m"

local unwanted_files = {
  "*.jpeg", "*.log", "*.css", "*.gif", "*.html", "*.jpg", "*.mp4", "*.png", "*.toml", "*.yml", "*.md",
  ".gitignore", ".editorconfig", ".gitattributes", ".luacheckrc", ".luarc.json", ".npmrc",
  ".pre-commit-config.yaml", ".themisrc", ".vimrc", "CHANGELOG.md", "TODO.md", "CONTRIBUTING.md",
  "Makefile", ".styluaignore", ".rockspec", ".lua-format"
}

local unwanted_folders = {".git", ".github", "_test", "test", "tests"}

local function print_header(text)
  print("\n" .. COLOR_BLUE .. BOLD .. "=== " .. text .. " ===" .. COLOR_RESET .. UNBOLD)
end

local function find_elements(dir, pattern, type)
  local command = type == "file"
    and 'find "%s" -type f -name "%s" 2>/dev/null'
    or 'find "%s" -type d -name "%s" 2>/dev/null'

  local pipe = io.popen(command:format(dir, pattern))
  local elements = {}
  for element in pipe:lines() do
    table.insert(elements, element)
  end
  pipe:close()
  return elements
end

local function delete_elements(list)
  if #list == 0 then
    print(COLOR_YELLOW .. "No elements found for deletion" .. COLOR_RESET)
    return 0
  end

  print_header("Elements to delete")
  print(COLOR_GRAY .. table.concat(list, "\n") .. COLOR_RESET)

  -- Confirmación del usuario
  io.write(COLOR_YELLOW .. BOLD .. "\nWARNING: " .. UNBOLD ..
    "You are about to delete " .. #list .. " elements. Continue? [y/N] " .. COLOR_RESET)
  local confirm = io.read("*l"):lower()

  if confirm ~= "y" then
    print(COLOR_RED .. "Deletion cancelled" .. COLOR_RESET)
    return 0
  end

  print_header("Deletion Progress")
  local deleted, failed = 0, 0
  for _, elem in ipairs(list) do
    io.write("Deleting " .. COLOR_GRAY .. elem .. COLOR_RESET .. " ... ")
    local success = os.execute("rm -rf '" .. elem .. "' 2>/dev/null")

    if success then
      deleted = deleted + 1
      print(SYM_CHECK)
    else
      failed = failed + 1
      print(SYM_CROSS .. " " .. COLOR_RED .. "Failed" .. COLOR_RESET)
    end
  end

  print_header("Deletion Summary")
  print(COLOR_GREEN .. BOLD .. "Successfully deleted: " .. UNBOLD .. deleted .. COLOR_RESET)
  print(COLOR_RED .. BOLD .. "Failed to delete: " .. UNBOLD .. failed .. COLOR_RESET)

  return deleted
end

local function main()
  print_header("Vault Cleaner Tool")

  local elements = {}

  -- Buscar archivos no deseados
  for _, pattern in ipairs(unwanted_files) do
    for _, file in ipairs(find_elements(".", pattern, "file")) do
      table.insert(elements, file)
    end
  end

  -- Buscar carpetas no deseadas
  for _, pattern in ipairs(unwanted_folders) do
    for _, folder in ipairs(find_elements(".", pattern, "folder")) do
      table.insert(elements, folder)
    end
  end

  -- Ejecutar proceso de eliminación
  local deleted_count = delete_elements(elements)

  -- Resultado final
  if deleted_count > 0 then
    print("\n" .. SYM_CHECK .. COLOR_GREEN .. " Cleanup completed successfully!" .. COLOR_RESET)
  else
    print("\n" .. SYM_WARN .. COLOR_YELLOW .. " No changes were made" .. COLOR_RESET)
  end
end

main()

