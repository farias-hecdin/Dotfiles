local vim = vim
local map = vim.keymap.set

-- Automatically Pair brackets, parethesis, quotes and more

-- General
map("i", "^v", "var(_)<left>", {desc = "var(_)"})
map("i", "^$", "${_}<left>", {desc = "${_}"})

-- Symbols
map("i", "^s1", "---------------------------------------------------------------------------", {desc = "--…"})
map("i", "^s2", "===========================================================================", {desc = "==…"})
map("i", "^s3", "###########################################################################", {desc = "##…"})
map("i", "^sa", "=>", {desc = "=>"})
map("i", "^sb", "{}", {desc = "{}"})
map("i", "^sk", "[]", {desc = "[]"})
map("i", "^sp", "()", {desc = "()"})
map("i", "^!", "!==", {desc = "!=="})
map("i", "^=", "===", {desc = "==="})
map("i", "^#", "###", {desc = "###"})
map("i", "^`", "```", {desc = "```"})

-- Markdown
map("i", "^mc", "```_```<left><left><left>", {desc = "``…"})

-- Lua and vim
map("i", "^lp", "print(_)<left>", {desc = "print(_)"})
map("i", "^vp", "vim.print(_)<left>", {desc = "vim.print(_)"})
map("i", "^vl", "log.info(_)<left>",  {desc = "log.info(_)"})

-- Html
map("i", "^ht", "</>", {desc = "</>"})

-- Javascript
map("i", "^jc", "console.log(_)<left>", {desc = "Console log"})
map("i", "^jA", "alert(_)<left>", {desc = "Alert"})
map("i", "^ja", "const name = () => {_}<left>", {desc = "Arrow function"})
map("i", "^ji", "import {_} from '_'<left>", {desc = "Import"})

-- Javascript, React
map("i", "^rc", "className={_}<left>", {desc = "ClassName"})
map("i", "^re", "useEffect(() => {_}, [])<left><left><left><left><left><left>", {desc = "useEffect"})

-- CSS
map("i", "^co", "* {outline: 1px dashed blue;}", {desc = "* {outline: … }"})


-- Php
map("i", "^pi", "<?php_?><left><left>", {desc = ""})
