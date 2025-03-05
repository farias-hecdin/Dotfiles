local M = {}

math.randomseed(os.time())

local bitand = bit32 and bit32.band or function(a, b)
  local result = 0
  local bitval = 1
  while a > 0 and b > 0 do
    if a % 2 == 1 and b % 2 == 1 then
      result = result + bitval
    end
    bitval = bitval * 2
    a = math.floor(a / 2)
    b = math.floor(b / 2)
  end
  return result
end


M.nanoid = function(size, custom)
  size = size or 21
  local alphabet = custom or "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
  local alphabet_length = #alphabet
  local id = {}

  for i = 1, size do
    local byte = math.random(255)
    local index = bitand(byte, 63) % alphabet_length + 1
    id[i] = alphabet:sub(index, index)
  end

  return table.concat(id)
end

return M
