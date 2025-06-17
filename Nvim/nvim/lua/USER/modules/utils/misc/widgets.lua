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
local WPM = 162.3

W.word_and_character_counter = function(enable_wip)
  local wc = vim.api.nvim_eval("wordcount()")
  local words = wc.visual_words or wc.words
  local chars = wc.visual_chars

  if not chars then
    return (" %s"):format(words)
  end

  local function format_wpm()
    local total_seconds = math.floor((words / WPM) * 60 + 0.5)
    return ("%d.%02d"):format(total_seconds / 60, total_seconds % 60)
  end

  return enable_wip
    and (" %s:(󰚜 %s 󰾹 %s)"):format(words, format_wpm(), chars)
    or (" %s:(󰾹 %s)"):format(words, chars)
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
