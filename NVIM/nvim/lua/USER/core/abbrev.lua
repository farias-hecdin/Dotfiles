local cmd = vim.cmd

-- Thanks to: https://github.com/NormTurtle/Windots/blob/main/vi/init.lua

-- Group 1
cmd("cnoreabbrev Q  q")
cmd("cnoreabbrev q1  q!")
cmd("cnoreabbrev Q1  q!")
cmd("cnoreabbrev Qa1 qa!")
cmd("cnoreabbrev Qa qa")
cmd("cnoreabbrev W  w")
cmd("cnoreabbrev Wq wq")
cmd("cnoreabbrev WQ wq")

-- Group 2
cmd("cnoreabbrev m mark")
cmd("cnoreabbrev s sort")
