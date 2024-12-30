local M = {}

M.to_lch = function(l, a, b)
  local c = math.sqrt(a*a + b*b)
  local h = math.atan2(b, a)
  if h < 0 then h = h + 2*math.pi end
  h = h * 180 / math.pi

  return l, c, h
end

return M
