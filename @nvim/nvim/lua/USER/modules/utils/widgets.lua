local W = {}

-- Print the current time
W.time = function()
  return " " .. os.date("%I:%M%p")
end

-- Print current date
W.date = function()
  return "󰸗 " .. os.date("%v")
end

-- Count the total number of words and characters
W.word_and_character_counter = function()
  local wc = vim.api.nvim_eval("wordcount()")
  local word = " "
  if wc["visual_chars"] then
    return word .. wc["visual_words"] .. ":" .. wc["visual_chars"]
  else
    return word .. wc["words"]
  end
end

-- 3rd party ------------------------------------------------------------------

-- Print startup time with Lazy.nvim
W.startuptime_lazy = function()
  local stats = require("lazy").stats()
  local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  return " " .. tostring(ms) .. "ms"
end

-- lint progress for statusline
W.lint_progress = function()
    local procs = require("lint").get_running_procs()
    if #procs == 0 then
        return " OK "
    end
    local string = ""
    for _, proc in ipairs(procs) do
        string = string .. proc .. " ,"
    end
    -- return "󱉶 " .. string.sub(string, 1, -2)
    return " Loading... "
end

return W
