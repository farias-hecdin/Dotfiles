local W = {}

-- Print the current time
W.app_clock = function()
  return " " .. os.date("%I:%M%p")
end

-- Print current date
W.app_date = function()
  return "󰸗 " .. os.date("%v")
end

-- Count the total number of words and characters
W.app_counter = function()
  local wc = vim.api.nvim_eval("wordcount()")
  local word = " "
  if wc["visual_chars"] then
    return word .. wc["visual_words"] .. ":" .. wc["visual_chars"]
  else
    return word .. wc["words"]
  end
end

-- Print startup time with Lazy.nvim
W.app_lazy = function()
  local stats = require("lazy").stats()
  local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  return " " .. tostring(ms) .. "ms"
end

return W
