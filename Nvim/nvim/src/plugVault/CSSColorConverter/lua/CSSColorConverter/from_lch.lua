local M = {}

-- Convert LCH color values to HEX color values
-- thanks to: https://stackoverflow.com/a/75850608/22265190
M.to_hex = function(l, c, h)
  local a = math.floor(c * math.cos(math.rad(h)) + 0.5)
  local b = math.floor(c * math.sin(math.rad(h)) + 0.5)
  -- Reference white values for CIE 1964 10° Standard Observer
  local xw, yw, zw = 0.948110, 1.00000, 1.07304

  local fy = (l + 16) / 116
  local fx = fy + (a / 500)
  local fz = fy - (b / 200)

  local x = xw * ((fx^3 > 0.008856) and fx^3 or ((fx - 16 / 116) / 7.787))
  local y = yw * ((fy^3 > 0.008856) and fy^3 or ((fy - 16 / 116) / 7.787))
  local z = zw * ((fz^3 > 0.008856) and fz^3 or ((fz - 16 / 116) / 7.787))

  local R = x * 3.2406 - y * 1.5372 - z * 0.4986
  local G = -x * 0.9689 + y * 1.8758 + z * 0.0415
  local B = x * 0.0557 - y * 0.2040 + z * 1.0570

  R = R > 0.0031308 and 1.055 * R^(1 / 2.4) - 0.055 or 12.92 * R
  G = G > 0.0031308 and 1.055 * G^(1 / 2.4) - 0.055 or 12.92 * G
  B = B > 0.0031308 and 1.055 * B^(1 / 2.4) - 0.055 or 12.92 * B

  R = math.floor(math.max(math.min(R, 1), 0) * 255 + 0.5)
  G = math.floor(math.max(math.min(G, 1), 0) * 255 + 0.5)
  B = math.floor(math.max(math.min(B, 1), 0) * 255 + 0.5)

  return string.format("#%02x%02x%02x", R, G, B)
end

return M
