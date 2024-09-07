local M = {}

-- thanks to: https://github.com/EmmanuelOga/columns/blob/master/utils/color.lua
local function hue2rgb(p, q, t)
  t = (t < 0) and t + 1 or (t > 1) and t - 1 or t
  if t < 0.16666667 then return p + (q - p) * 6 * t end
  if t < 0.5 then return q end
  if t < 0.66666667 then return p + (q - p) * (0.66666667 - t) * 6 end
  return p
end

local function hslToRgb(h, s, l)
  if s == 0 then return l, l, l end
  local q = l < 0.5 and l * (1 + s) or l + s - l * s
  local p = 2 * l - q
  return hue2rgb(p, q, h + 0.33333333), hue2rgb(p, q, h), hue2rgb(p, q, h - 0.33333333)
end

M.hslToHex = function(h, s, l)
  local r, g, b = hslToRgb(h * 0.002777778, s * 0.01, l * 0.01)
  return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
end

return M
