local M = {}

-- Convert HEX color values to RGB color values
M.to_rgb = function(hex)
  hex = hex:gsub("#","")
  return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

return M
