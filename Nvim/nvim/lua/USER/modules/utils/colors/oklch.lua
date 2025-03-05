local M = {}
local utils = require("USER.modules.utils.colors.rgb")

M.oklchToHex = function(L, C, H)
  local r, g, b = M.oklch_to_rgb(L, C, H)
  return utils.rgbToHex(r, g, b)
end


function M.oklch_to_rgb(L, C, H)
  L = L / 100
  -- Conversión de OKLCH a OKLab
  local hue_rad = math.rad(H)
  local a = C * math.cos(hue_rad)
  local b = C * math.sin(hue_rad)

  -- Conversión de OKLab a LMS (no lineal)
  local l_prime = L + 0.3963377774 * a + 0.2158037573 * b
  local m_prime = L - 0.1055613458 * a - 0.0638541728 * b
  local s_prime = L - 0.0894841775 * a - 1.2914855480 * b

  -- Linealización LMS
  local l = l_prime * l_prime * l_prime
  local m = m_prime * m_prime * m_prime
  local s = s_prime * s_prime * s_prime

  -- Conversión LMS a RGB lineal
  local R =  4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s
  local G = -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s
  local B = -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s

  -- Función de corrección gamma
  local function gamma_correct(c)
    if c <= 0.0031308 then
      return 12.92 * c
    else
      return 1.055 * (c^(1/2.4)) - 0.055
    end
  end

  -- Aplicar gamma y convertir a 0-255
  R = gamma_correct(R)
  G = gamma_correct(G)
  B = gamma_correct(B)

  -- Convertir a valores enteros y asegurar rango
  local r = math.floor(R * 255 + 0.5)
  local g = math.floor(G * 255 + 0.5)
  local b = math.floor(B * 255 + 0.5)

  return math.max(0, math.min(255, r)), math.max(0, math.min(255, g)), math.max(0, math.min(255, b))
end

return M
