local M = {}
local Json = require("vendor.json_lua.json")
local notify = require("LinkRef.notify")

-- Función para verificar si un archivo JSON está vacío
function M.is_json_file_empty(file_path)
  local content = M.read_json_file(file_path)
  if not content then
    return true
  end
end


-- Función para leer un archivo JSON
function M.read_json_file(file_path)
  local file = io.open(file_path, "r")
  if not file then
    notify.error("No se pudo abrir el archivo: " .. file_path)
  end

  local content = file:read("*all")
  file:close()
  if not content or content:match("^%s*$") then
    return nil
  end
  return Json.decode(content)
end


-- Función para escribir un archivo JSON
function M.write_json_file(file_path, data)
  local file = io.open(file_path, "w")
  if not file then
    notify.error("No se pudo abrir el archivo: " .. file_path)
  end
  file:write(Json.encode(data))
  file:close()
end

return M
