local M = {}

-- Convert XYZ color values to LAB color values
M.to_lab = function(x, y, z)
  local function f(t)
    if t > 0.008856 then
      return t^(1/3)
    else
      return 7.787 * t + 16/116
    end
  end

  local xn, yn, zn = 95.047, 100.0, 108.883 -- Reference white D65
  x, y, z = x / xn, y / yn, z / zn

  local l = 116 * f(y) - 16
  local a = 500 * (f(x) - f(y))
  local b = 200 * (f(y) - f(z))

  return l, a, b
end

return M
