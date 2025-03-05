local M = {}

-- Cache de funciones de la API de Neovim
local api = vim.api
local fn = vim.fn
local str_byteindex = vim.str_byteindex
local str_utfindex = vim.str_utfindex


--- Obtiene el texto de la línea especificada
local get_line = function(line_num)
  return api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1] or ''
end


--- Obtiene la posición ajustada de una marca
local get_mark = function(mark)
  local pos = api.nvim_buf_get_mark(0, mark)
  return { pos[1], pos[2] + 1 } -- Convertir a 1-based
end


--- Manejo optimizado de posiciones UTF-8
local adjust_position = function(pos, mode)
  local line = get_line(pos[1])
  local byte_idx = pos[2] - 1 -- Convertir a índice de bytes 0-based

  if mode == 'start' then
    local char_idx = str_utfindex(line, byte_idx)
    return str_byteindex(line, char_idx) + 1 -- 1-based
  else
    local char_idx = str_utfindex(line, byte_idx)
    local end_byte = str_byteindex(line, char_idx + 1) or #line
    return end_byte -- 0-based (no +1 para posición final)
  end
end


--- Captura la selección visual con manejo eficiente de UTF-8
M.capture_visual_selection = function()
  local visual_mode = fn.visualmode()
  local s_mark = get_mark('<')
  local e_mark = get_mark('>')

  if not s_mark or not e_mark then return end

  -- Ajustar posiciones para UTF-8
  s_mark[2] = adjust_position(s_mark, 'start')
  e_mark[2] = adjust_position(e_mark, 'end')

  -- Manejo de modo línea
  if visual_mode == 'V' then
    local e_line = get_line(e_mark[1])
    s_mark[2] = 1
    e_mark[2] = #e_line + 1
  end

  -- Obtener texto
  local text = api.nvim_buf_get_text(0, s_mark[1] - 1, s_mark[2] - 1, e_mark[1] - 1, e_mark[2], {})
  return { first_pos = s_mark, last_pos = e_mark }, text
end


--- Modificación optimizada del texto
M.change_text = function(selection, text)
  if not selection then return end

  api.nvim_buf_set_text(
    0,
    selection.first_pos[1] - 1, selection.first_pos[2] - 1,
    selection.last_pos[1] - 1, selection.last_pos[2],
    text
  )
end

return M

