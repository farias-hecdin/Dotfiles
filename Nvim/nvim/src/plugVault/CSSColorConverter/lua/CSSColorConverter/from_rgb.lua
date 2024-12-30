local M = {}
local utils = require('CSSColorConverter.utils')

-- Convert RGB color values to HEX color values
local function hex_to_string(number)
  local chars = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"}
  local low = number % 16
  local high = math.floor(number * 0.0625) % 16
  return chars[high+1] .. chars[low+1]
end

M.to_hex = function(r, g, b)
  return "#" .. hex_to_string(r) .. hex_to_string(g) .. hex_to_string(b)
end

-- Convert RGB color values to XYZ color values
M.to_xyz = function(R, G, B)
  local r = (R / 255)
  local g = (G / 255)
  local b = (B / 255)

  if r > 0.04045 then r = ((r + 0.055) / 1.055)^2.4 else r = r / 12.92 end
  if g > 0.04045 then g = ((g + 0.055) / 1.055)^2.4 else g = g / 12.92 end
  if b > 0.04045 then b = ((b + 0.055) / 1.055)^2.4 else b = b / 12.92 end

  local x = r * 0.4124 + g * 0.3576 + b * 0.1805
  local y = r * 0.2126 + g * 0.7152 + b * 0.0722
  local z = r * 0.0193 + g * 0.1192 + b * 0.9505

  return x * 100, y * 100, z * 100
end

-- Convert RGB color values to HSL color values
-- thanks to: https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua
M.to_hsl = function(r, g, b)
  r, g, b = r / 255, g / 255, b / 255
  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h, s, l
  l = (max + min) / 2

  if max == min then
    h, s = 0, 0
  else
    local d = max - min
    if l > 0.5 then s = d / (2 - max - min) else s = d / (max + min) end
    if max == r then
      h = (g - b) / d
      if g < b then h = h + 6 end
    elseif max == g then h = (b - r) / d + 2
    elseif max == b then h = (r - g) / d + 4
    end
    h = h / 6
  end
  return utils.round((h * 360), 0), utils.round((s * 100), 0), utils.round((l * 100), 0)
end

return M
