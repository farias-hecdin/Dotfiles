-- Command-line abbreviations
-- Thanks to: https://github.com/NormTurtle/Windots/blob/main/vi/init.lua

local abbreviations = {
  -- Force-quit shortcuts
  { "q1",  "q!" },
  { "qa1", "qa!" },

  -- Built-in commands
  { "nw", "set numberwidth=4" },
  { "mk", "mark" },
  { "st", "sort" },
  { "cc", "colorcolumn" },

  -- Third-party plugins
  { "Mn", "MiniNotifyHistory" },
  { "Tc", "MDToc" },
  { "Ps", "PomodoroStart" },
}

for _, abbr in ipairs(abbreviations) do
  vim.cmd.cnoreabbrev(abbr[1] .. " " .. abbr[2])
end

