local W = {}
local format = string.format

local round = function(number, decimals)
  local power = 10 ^ decimals
  return math.floor(number * power + 0.5) / power
end

-- Print the current time
W.time = function()
  return format("  %s ", os.date("%I:%M%p"))
end

-- Print current date
W.date = function()
  return format("󰸗 %s", os.date("%v"))
end

-- Count the total number of words and characters
W.word_and_character_counter = function(enable_wip)
  local WPM = 162.3
  local wc = vim.api.nvim_eval("wordcount()")
  local wc_words = wc["visual_words"]
  local wc_chars = wc["visual_chars"]

  local function dm2ms(decimalMin)
    local min = math.floor(decimalMin)
    local seg = (decimalMin - min) * 60
    return min, math.floor(seg + 0.5)
  end
  local function calc_wpm()
    local res = (wc_words / WPM)
    local min, seg = dm2ms(round(res, 2))
    if seg < 10 then
      return min ..".0"..seg
    else
      return min .."."..seg
    end
  end

  if wc_chars and not enable_wip then
    return format(" %s:(󰾹 %s)", wc_words, wc_chars)
  elseif wc_chars and enable_wip then
    local wpm = tostring(calc_wpm())
    return format(" %s:(󰚜 %s 󰾹 %s)", wc_words, wpm, wc_chars)
  else
    return format(" %s", wc["words"])
  end
end

-- 3rd party ------------------------------------------------------------------

-- Print startup time with Lazy.nvim
W.startuptime_lazy = function()
  local stats = require("lazy").stats()
  local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  return format("󰓅 %sms", tostring(ms))
end

-- Lint progress for statusline
W.lint_progress = function()
  local ok, lint = pcall(require, "lint")
  if not ok then
    return ""
  end

  local procs = lint.get_running_procs()
  local string = ""
  if #procs == 0 then
    return " OK "
  end
  for _, proc in ipairs(procs) do
    string = string .. proc .. " ,"
  end
  return " Loading... "
end

return W
