local M = {}
-- Thanks to: https://stackoverflow.com/a/75850608/22265190

local function adjustColor(color)
  if color > 0.0031308 then
    return 1.055 * color^0.416666667 - 0.055  -- 1/2.4
  else
    return 12.92 * color
  end
end


function M.lchToHex(l, c, h)
  local a = math.floor(c * math.cos(math.rad(h)) + 0.5)
  local b = math.floor(c * math.sin(math.rad(h)) + 0.5)

  local xw, yw, zw = 0.948110, 1.00000, 1.07304

  local fy = (l + 16) * 0.008620689655172414  -- 1/116
  local fx = fy + (a * 0.002)  -- 1/500
  local fz = fy - (b * 0.005)  -- 1/200

  local fx3 = fx * fx * fx
  local fy3 = fy * fy * fy
  local fz3 = fz * fz * fz

  local x = xw * ((fx3 > 0.008856) and fx3 or ((fx - 0.137931034482759) * 0.128418549))  -- 16/116, 1/7.787
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

return M
