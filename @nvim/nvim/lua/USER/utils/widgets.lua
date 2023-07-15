local W = {}

-- Clock
W.app_clock = function()
  return " " .. os.date("%I:%M%p")
end

-- Date
W.app_date = function()
  return " " .. os.date("%v")
end

-- Word counter
W.app_counter = function()
  local wc = vim.api.nvim_eval("wordcount()")
  local word = " "
  local char = ":"
  if wc["visual_chars"] then
    return
      word .. wc["visual_words"] .. char .. wc["visual_chars"]
  else
    return word .. wc["words"]
  end
end

-- Startuptime
W.app_lazy = function()
  local stats = require("lazy").stats()
  local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  return " " .. tostring(ms) .. "ms"
end

-- Date and hour
W.app_date_and_time = function()
  local time = " " .. os.date("%I:%M%p")
  local date = " " .. os.date("(%A) %v")
  return date .. "   " .. time
end

return W
