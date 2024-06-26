local M = {}

local function hexToString(number)
  local chars = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"}
  local low = number % 16
  local high = math.floor(number / 16) % 16
  return chars[high + 1] .. chars[low + 1]
end

M.rgbToHex = function(r, g, b)
  return "#" .. hexToString(r) .. hexToString(g) .. hexToString(b)
end

return M
