local M = {}
local notify = require("LinkRef.notify")

-- Eliminar una subtabla por su índice
function M.remove_subtable(mainTable, index)
  local size = #mainTable
  if index > 0 and index <= size then
    table.remove(mainTable, index)
  else
    notify.error("Índice fuera de rango: "..index.." (Tamaño: "..size..")", 2)
  end
end


-- Reorganizar los índices
function M.reorganize_indices(mainTable)
  return table.move(mainTable, 1, #mainTable, 1, {})
end


-- Extraer el valor e índice de un registro
function M.extract_value_and_index(records, matching_key)
  for index = 1, #records do
    local record = records[index]
    local key = next(record)  -- Obtiene la primera y única clave
    if key == matching_key then
      return record[key], index
    end
  end
end


-- Definir la función en Lua
function M.add_text_to_buffer(token)
  local comment = string.format("<!-- %s -->", token)

  -- Insertar texto y actualizar cursor en una sola operación
  vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, 0, false, {comment})
  vim.api.nvim_win_set_cursor(0, {1, 0})
end


-- Verificar si un archivo o directorio existe
local function exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat ~= nil
end


-- Crear un directorio si no existe
function M.create_dir_if_missing(path)
  if not exists(path) then
    vim.loop.fs_mkdir(path, 493) -- 493 es el permiso 0755 en octal
    notify.info("Directorio creado: " .. path)
  end
end


-- Crear un archivo si no existe
function M.create_file_if_missing(path)
  if not exists(path) then
    local file = io.open(path, "w")
    if file then
      file:close()
      notify.info("Archivo creado: " .. path)
    else
      notify.error("Error al crear el archivo: " .. path)
    end
  else
    notify.warn("El archivo ya existe: " .. path)
  end
end

return M
