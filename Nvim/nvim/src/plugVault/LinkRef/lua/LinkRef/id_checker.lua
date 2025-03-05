local M = {}
local notify = require("LinkRef.notify")

--- Encontrar todas las coincidencias con sus posiciones
function M.find_matches(content)
  local matches = {}
  local pattern = "%]%((L%-[%a%d]+)%)"
  local start_idx = 1

  while true do
    local start_pos, end_pos, captured = content:find(pattern, start_idx)
    if not start_pos then
      break
    end

    table.insert(matches, {start_pos = start_pos, end_pos = end_pos, text = captured})

    -- Continuar después de esta coincidencia
    start_idx = end_pos + 1
  end
  return matches
end


--- Capturar todas los ID que comiencen con "L-" seguido de N caracteres
function M.capture_L_words(length, show)
  local captured_words = {}
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local pattern = "L%-" .. string.rep("[%a%d]", length)

  for _, line in ipairs(lines) do
    for word in line:gmatch(pattern) do
      table.insert(captured_words, word)
    end
  end

  if #captured_words == 0 and show then
    notify.warn("No se han encontrado IDs válidos.")
    return nil
  end
  return captured_words
end


function M.verify_file_match()
  -- Capturar el texto precedido por "R-XXX"
  local captured_id = M.capture_id()
  if not captured_id then
    notify.error("No se encontró texto precedido por 'R-'.")
  end

  -- Encontrar coincidencia
  return M.compare_with_files(captured_id)
end


-- Función para capturar el texto precedido por "TOKEN-XXX"
function M.capture_id()
  local captured_text = nil
  -- Obtener el buffer actual
  local buf = vim.api.nvim_get_current_buf()
  -- Obtener todas las líneas del buffer
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  -- Recorrer todas las líneas y buscar el texto precedido por "TOKEN-XXX"
  for _, line in ipairs(lines) do
    local taken_text = line:match("R%-([%a%d]+)")
    if taken_text then
      captured_text = taken_text
      break
    end
  end

  return captured_text
end


-- Comparar el texto capturado con los nombres de archivos en el directorio nvim/LinkRef
function M.compare_with_files(captured_text)
  local fn = vim.fn
  local fs = vim.fs
  local target = captured_text .. ".json"

  -- Construir path usando API segura
  local dir = fs.joinpath(fn.stdpath('data'), 'LinkRef')
  local file_path = fs.joinpath(dir, target)

  -- Verificación directa del archivo
  if fs.find(target, { path = dir, type = 'file', limit = 1 })[1] then
    return file_path
  end

  -- Manejo de error mejorado
  notify.error("ID no encontrado: '"..captured_text.."'\n".. "Buscado en: "..dir)
  return nil
end

return M
