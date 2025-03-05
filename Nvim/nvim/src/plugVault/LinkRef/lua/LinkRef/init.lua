local M = {}
local config = require('LinkRef.config')
local utils = require('LinkRef.utils')
local id = require('LinkRef.id_generator')
local url = require("LinkRef.url_manager")
local json = require("LinkRef.json_manager")
local checker = require('LinkRef.id_checker')
local tops = require("LinkRef.select_text")
local notify = require("LinkRef.notify")

M.setup = function(options)
  -- Merge the user-provided options with the default options
  config.options = vim.tbl_deep_extend("keep", options or {}, config.options)

  -- Enable keymap if they are not disableds
  if not config.options.disable_keymaps then
    local opts = {buffer = 0, silent = true}
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'LinkRef keymaps',
      callback = function()
        vim.keymap.set('n', '<leader>xi', ":lua require('LinkRef').initial_config()<CR>", opts)
        vim.keymap.set('n', '<leader>xa', ":lua require('LinkRef').analyze_buffer()<CR>", opts)
        vim.keymap.set('n', '<leader>xg', ":lua require('LinkRef').go_captured()<CR>", opts)
        vim.keymap.set('v', '<leader>xg', ":lua require('LinkRef').go_selected()<CR>", opts)
        vim.keymap.set('v', '<leader>xa', ":lua require('LinkRef').add_identifier()<CR>", opts)
        vim.keymap.set('v', '<leader>xs', ":lua require('LinkRef').show_content()<CR>", opts)
      end,
    })
  end
end


-- Analizar buffer
function M.analyze_buffer()
  local filePath = checker.verify_file_match()
  if not filePath then
    return
  end

  local ids_captured = checker.capture_L_words(config.options.id_length, false) or {}
  local records = json.read_json_file(filePath) or {}

  if #records == 0 then
    return
  end

  -- Crear conjunto para búsquedas O(1)
  local id_set = {}
  for _, i in ipairs(ids_captured) do
    id_set[i] = true
  end

  -- Colectar índices y claves a eliminar
  local indices_to_delete = {}
  local delete_keys = {}

  for index = 1, #records do
    local record = records[index]
    local key = next(record)
    if not id_set[key] then
      table.insert(indices_to_delete, index)
      table.insert(delete_keys, key)
    end
  end

  -- Procesar eliminaciones
  if #indices_to_delete > 0 then
    -- Eliminar en orden inverso para mantener índices válidos
    table.sort(indices_to_delete, function(a, b) return a > b end)
    for _, index in ipairs(indices_to_delete) do
      utils.remove_subtable(records, index)
    end

    -- Reorganizar y guardar una sola vez
    records = utils.reorganize_indices(records)
    json.write_json_file(filePath, records)
    notify.info("Se eliminó " .. #indices_to_delete .. " IDs obsoletos.")
  else
    notify.info("No hay IDs obsoletos para eliminar.")
  end
end


--- Mostrar el enlace oculto
function M.show_content()
  local filePath = checker.verify_file_match()
  if not filePath then
    return
  end

  -- Capturar el ID y extraer su valor
  local posText, selectText = tops.capture_visual_selection()
  local selectTextLen = string.len(selectText[1])
  local idTextLength = config.options.id_length + 2
  if selectTextLen > idTextLength then
    notify.warn("ID inválido. La longitud proporcionada es mayor a la permitida: "..idTextLength)
    return
  end

  -- Actualizar el registro Json
  local existingData = json.read_json_file(filePath) or {}
  selectText[1], _ = utils.extract_value_and_index(existingData, selectText[1])
  -- INFO: No actualizar el registro para evitar borrar copias de un ID en el documento
  -- utils.remove_subtable(existingData, index)
  -- existingData = utils.reorganize_indices(existingData)
  -- json.write_json_file(filePath, existingData)

  -- Sutituir el ID por el valor
  tops.change_text(posText, selectText)
end


--- Añadir un ID
function M.add_identifier()
  local filePath = checker.verify_file_match()
  if not filePath then
    return
  end

  -- Cargar datos existentes y preparar estructura de IDs
  local existingData = json.read_json_file(filePath) or {}
  local idLength = math.max(config.options.id_length, 2)  -- Mínimo 2 caracteres
  local alphabet = config.options.custom_alphabet
  local maxAttempts = 50

  -- Preprocesar IDs existentes para búsquedas rápidas
  local existingIDs = {}
  for _, record in ipairs(existingData) do
    local idx = next(record) -- Si cada registro solo tiene una clave
    existingIDs[idx] = true
  end


  -- Generador de IDs
  function generate_unique_id()
    local attempts = 0
    local idRef

    repeat
      attempts = attempts + 1
      if attempts > maxAttempts then
        notify.error("No se pudo generar un ID único después de " .. maxAttempts .. " intentos.")
        return nil
      end
      idRef = "L-" .. id.nanoid(idLength, alphabet)
    until not existingIDs[idRef]

    -- Prevenir colisiones en esta sesión
    existingIDs[idRef] = true
    return idRef
  end


  -- Operaciones de escritura
  local take_id = generate_unique_id()
  if take_id == nil then
    return
  end

  local posText, selectText = tops.capture_visual_selection()
  table.insert(existingData, { [take_id] = selectText[1] })
  json.write_json_file(filePath, existingData)

  -- Actualizar el texto
  selectText[1] = take_id
  tops.change_text(posText, selectText)
end


--- Abrir el link con el navegador en el modo NORMAL
function M.go_captured()
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local line_content = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
  local cursor_col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local matches = checker.find_matches(line_content)

  if #matches > 0 then
    for _, match in ipairs(matches) do
      -- Verificar si el cursor está dentro de esta coincidencia
      if cursor_col >= match.start_pos and cursor_col <= match.end_pos then
        M.go_selected(match.text)
        return
      end
    end
    notify.info("Cursor no está dentro de ninguna coincidencia")
  end
end


--- Abrir el link con el navegador en el modo VISUAL
function M.go_selected(captured)
  local filePath = checker.verify_file_match()
  if not filePath then
    return
  end

  -- Obten el link y abrelo en el navegador
  if not captured then
    local _, selectText = tops.capture_visual_selection()
    captured = selectText[1]
  end

  local existingData = json.read_json_file(filePath) or {}
  local link, _ = utils.extract_value_and_index(existingData, captured)
  url.open_in_browser(link)
end


--- Inicializar un registro de IDs
function M.initial_config()
  local captured_id = checker.capture_id()

  -- Si el documento no tiene un ID token, añade uno nuevo
  if not captured_id then
    local id_token = id.nanoid(21)
    local id_generated = "R-" .. id_token
    local dir_path = string.format("%s/LinkRef/", vim.fn.stdpath('data'))
    local file_path = string.format("%s%s.json", dir_path, id_token)

    -- Crea los elementos correspondientes y añade el token al inicio del documento
    utils.create_dir_if_missing(dir_path)
    utils.create_file_if_missing(file_path)
    utils.add_text_to_buffer(id_generated)
    notify.info("Token de referencia creado con éxito.")
  else
    notify.warn("La referencia R-" .. captured_id .. " ya existe.")
  end
end

return M
