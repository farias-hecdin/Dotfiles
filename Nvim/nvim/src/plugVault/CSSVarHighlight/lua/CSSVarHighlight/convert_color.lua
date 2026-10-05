local M = {}

--- Rgb to Hex color ----------------------------------------------------------
local function rgbToHex(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

--- Lch to Hex color ----------------------------------------------------------
-- thanks to: https://stackoverflow.com/a/75850608/22265190
local function adjustColor(color)
  if color > 0.0031308 then
    return 1.055 * color ^ 0.416666667 - 0.055
  else
    return 12.92 * color
  end
end

local function lchToHex(l, c, h)
  local a = math.floor(c * math.cos(math.rad(h)) + 0.5)
  local b = math.floor(c * math.sin(math.rad(h)) + 0.5)

  local xw, yw, zw = 0.948110, 1.00000, 1.07304

  local fy = (l + 16) * 0.008620689655172414
  local fx = fy + (a * 0.002)
  local fz = fy - (b * 0.005)

  local fx3 = fx * fx * fx
  local fy3 = fy * fy * fy
  local fz3 = fz * fz * fz

  local x = xw * ((fx3 > 0.008856) and fx3 or ((fx - 0.137931034482759) * 0.128418549))
  local y = yw * ((fy3 > 0.008856) and fy3 or ((fy - 0.137931034482759) * 0.128418549))
  local z = zw * ((fz3 > 0.008856) and fz3 or ((fz - 0.137931034482759) * 0.128418549))

  local R = x * 3.2406 - y * 1.5372 - z * 0.4986
  local G = -x * 0.9689 + y * 1.8758 + z * 0.0415
  local B = x * 0.0557 - y * 0.2040 + z * 1.0570

  R = adjustColor(R)
  G = adjustColor(G)
  B = adjustColor(B)

  R = math.floor(math.max(math.min(R, 1), 0) * 255 + 0.5)
  G = math.floor(math.max(math.min(G, 1), 0) * 255 + 0.5)
  B = math.floor(math.max(math.min(B, 1), 0) * 255 + 0.5)

  return string.format("#%02x%02x%02x", R, G, B)
end

--- Hsl to Hex color ----------------------------------------------------------
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

local function hslToHex(h, s, l)
  local r, g, b = hslToRgb(h * 0.002777778, s * 0.01, l * 0.01)
  return string.format("#%02x%02x%02x", r * 255, g * 255, b * 255)
end

-- A "number" in a CSS color function: optional sign, digits, optional
-- decimal part, plus an optional trailing unit ("%", "deg", etc.) that is
-- consumed but not captured. Handles "50", "56.2", "56.2%" and "300deg"
-- all with the same pattern (unlike the old "%d+%.?%d+", this doesn't
-- require a minimum of 2 digits).
local NUMBER = "(%-?%d+%.?%d*)%%?%a*"
-- Values may be separated by a comma, whitespace, or both ("56%, 72, 50"
-- and "56% 72 50" must both work).
local SEP = "%s*,?%s*"

local FORMATS = {
  -- %f[%a] excludes "oklch(...)" (different color space/ranges) from
  -- being mistakenly parsed as "lch(...)": "lch" is a substring of
  -- "oklch", but math for one is wrong for the other.
  { name = "lch", pattern = "%f[%a]lch%(" .. NUMBER .. SEP .. NUMBER .. SEP .. NUMBER, convert = lchToHex },
  { name = "hsl", pattern = "hsl%(" .. NUMBER .. SEP .. NUMBER .. SEP .. NUMBER, convert = hslToHex },
  { name = "rgb", pattern = "rgb%(" .. NUMBER .. SEP .. NUMBER .. SEP .. NUMBER, convert = rgbToHex },
}

--- Tries to extract 3 numeric components with `pattern` and convert them
-- with `converter`. Returns nil (never throws) if the value doesn't match
-- the expected shape, so unsupported/unexpected CSS syntax degrades
-- gracefully instead of crashing the whole highlight update.
local function try_convert(value, pattern, converter)
  local a, b, c = value:match(pattern)
  a, b, c = tonumber(a), tonumber(b), tonumber(c)
  if not (a and b and c) then return nil end
  return converter(a, b, c)
end

--- Converts color values in various formats to hex color ---------------------
M.convert_color = function(data)
  local colors = {}

  for name, value in pairs(data) do
    local hex = value:match("%#%x%x%x%x%x%x")

    if hex then
      colors[name] = hex
    else
      for _, format in ipairs(FORMATS) do
        if value:match(format.name .. "%(") then
          local result = try_convert(value, format.pattern, format.convert)
          if result then
            colors[name] = result
          else
            vim.print(("[CSSVarHighlight] Couldn't parse '%s: %s' as %s(); skipping.")
              :format(name, value, format.name))
          end
          break
        end
      end
    end
  end

  return colors
end

return M

