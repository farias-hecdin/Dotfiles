local M = {}

--- Extracts CSS custom properties matching `pattern` from a file, in a
-- single pass over its lines (no intermediate tables, no double regex).
-- @param fpath string Path to the CSS file.
-- @param pattern string Lua pattern used to filter property names.
-- @return table<string, string> Map of property name -> raw value.
M.get_css_attribute = function(fpath, pattern)
  local key_value_pairs = {}

  local file = io.open(fpath, "r")
  if not file then return key_value_pairs end

  for line in file:lines() do
    local key, value = line:match("([-_%w]+)%s*:%s*([^;]+)")
    if key and key:match(pattern) then
      key_value_pairs[key] = value:match("^%s*(.-)%s*$")
    end
  end
  file:close()

  return key_value_pairs
end

return M

