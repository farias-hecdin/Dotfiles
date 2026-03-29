local W = {}
local format = string.format

-- Round floating numbers
local round = function(number, decimals)
  local power = 10 ^ decimals
  return math.floor(number * power + 0.5) / power
end


-- Print the current time
W.time = function()
  return format(" %s", os.date("%I:%M%p"))
end


-- Print current date
W.date = function()
  return format("󰸗 %s", os.date("%v"))
end


-- Count the total number of words and characters
W.word_and_character_counter = function()
  local wc = vim.api.nvim_eval("wordcount()")
  local chars = wc.visual_chars
  local words = wc.visual_words or wc.words
  local tokens = math.ceil(words / 4)

  if not chars then
    return (" %s"):format(words)
  end
  return (" %s 󰾹 %s 󰚩 %s"):format(words, chars, tokens)
end



-- 3rd party ------------------------------------------------------------------


-- Print startup time (ms) with Lazy.nvim
W.startuptime_lazy = function()
  local stats = require("lazy").stats()
  local seconds = stats.startuptime / 1000
  return ("󰓅 %.2fs"):format(seconds)
end


-- Lint progress for statusline
W.lint_progress = function()
  local ok, lint = pcall(require, "lint")
  if not ok then return "" end

  local procs = lint.get_running_procs()
  return #procs == 0 and " OK" or " Wait…"
end


return W
