-- MIT License Copyright (c) 2023 Hecdin Farias
-- This script removes unwanted files and folders from the Vault folder.

local gray = "\27[37m"
local bold = "\27[1m"
local unstyle = "\27[0m"

local unwanted_files = {
  "*.jpeg", "*.log", "*.css", "*.gif", "*.html", "*.jpg", "*.mp4", "*.png", "*.toml", "*.yml",
  ".gitignore", ".editorconfig", ".gitattributes", ".luacheckrc", ".luarc.json", ".npmrc",
  ".pre-commit-config.yaml", ".themisrc", ".vimrc", "CHANGELOG.md", "TODO.md", "CONTRIBUTING.md",
  "Makefile", ".styluaignore", ".rockspec", ".lua-format"
}

local unwanted_folders = {".git", ".github", "_test", "test", "tests"}

local function find_files(dir, pattern)
  local pipe = io.popen('find "' .. dir .. '" -type f -name "' .. pattern .. '"')
  local files = {}
  for file in pipe:lines() do
    table.insert(files, file)
  end
  pipe:close()
  return files
end

local function find_folders(dir, pattern)
  local pipe = io.popen('find "' .. dir .. '" -type d -name "' .. pattern .. '"')
  local folders = {}
  for folder in pipe:lines() do
    table.insert(folders, folder)
  end
  pipe:close()
  return folders
end

local function delete_elements(list)
  if #list > 0 then
    print(bold .. "Deleting:" .. unstyle)
    for _, elem in ipairs(list) do
      print(gray .. elem .. unstyle)
      os.execute("rm -rf " .. elem)
    end
    print("")
  end
end

local function main()
  local list = {}

  for _, file in ipairs(unwanted_files) do
    local files = find_files(".", file)
    for _, f in ipairs(files) do
      table.insert(list, f)
    end
  end

  for _, folder in ipairs(unwanted_folders) do
    local folders = find_folders(".", folder)
    for _, f in ipairs(folders) do
      table.insert(list, f)
    end
  end

  delete_elements(list)

  -- Print a success message.
  print(bold .. "Successfully deleted unwanted folders and files." .. unstyle)
end

main()
