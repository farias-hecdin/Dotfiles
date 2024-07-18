-- Thanks to: https://github.com/NormTurtle/Windots/blob/main/vi/init.lua
local cmd = vim.cmd

-- Group 1
cmd("cnoreabbrev q1  q!")
cmd("cnoreabbrev qa1 qa!")

-- Group 2 (built-in)
cmd("cnoreabbrev mk mark")
cmd("cnoreabbrev st sort")
cmd("cnoreabbrev cc colorcolumn")

-- Group 3 (third-party)
cmd("cnoreabbrev Mn MiniNotifyHistory")
cmd("cnoreabbrev Tc MDToc")
cmd("cnoreabbrev Ps PomodoroStart")
