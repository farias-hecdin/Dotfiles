local M = {}

M.rgbToHex = function(r, g, b)
  local function toHex(num)
    return string.format("%02x", num)
  end
  return "#" .. toHex(r) .. toHex(g) .. toHex(b)
end

return M
