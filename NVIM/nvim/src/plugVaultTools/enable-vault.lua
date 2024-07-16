local M = {}
local file_path = "./test/example.lua"

function M.read_file(file_to_read)
  local file = io.open(file_to_read, "r")
  if not file then error("Error opening file") end

  local content = file:read("*a")
  file:close()
  if content:match("%@no%-check") then return end

  return content
end

function M.write_file(file_to_write, content)
  local file = io.open(file_to_write, "w")
  if not file then error("Error creating file") end
  file:write(content)
  file:close()
end

function M.comment_dir_property(enable, path)
  local replace = {
    enable and "[^--]%sdir%s=" or "[^--]%surl%s=",
    enable and "  -- dir =" or "  -- url =",
    enable and "%s%-%-%s*url" or "%s%-%-%s*dir",
    enable and " url" or " dir",
  }

  for i = 1, 3, 2 do
    local content = M.read_file(path)
    if not content then return end

    local new_content = content:gsub(replace[i], replace[i + 1])
    M.write_file(path, new_content)
  end
end

local function main()
  local function get_input(prompt)
    io.write(prompt)
    return io.read()
  end

  local function extract_list(file_to_iterate)
    local files = {}
    for line in io.lines(file_to_iterate) do
      if line:match(".lua") then
        table.insert(files, line)
      end
    end
    return files
  end

  local list = extract_list("../plugin-setup-files.txt")
  local enable_dir = get_input('(1) Comment "dir" property or (2) uncomment it?: ')
  local enable = nil

  if enable_dir == "1" then
    enable = true
  elseif enable_dir == "2" then
    enable = false
  end

  for _, file in pairs(list) do
    local path = "../../lua/USER/modules/" .. file
    print("Edit: " .. file)
    M.comment_dir_property(enable, path)
  end
end

main()
