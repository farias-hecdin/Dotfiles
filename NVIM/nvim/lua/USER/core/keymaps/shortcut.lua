local vim = vim
local map = vim.keymap.set

-- Automatically Pair brackets, parethesis, quotes and more -------------------

-- Vocals -----------------------------
local accented_vocals = {
  ["A"] = "Á",
  ["a"] = "á",
  ["E"] = "É",
  ["e"] = "é",
  ["I"] = "Í",
  ["i"] = "í",
  ["O"] = "Ó",
  ["o"] = "ó",
  ["U"] = "Ú",
  ["u"] = "ú"
}

for vocal, accented in pairs(accented_vocals) do
  map("i", "^´" .. vocal, accented, {desc = ("Change '%s' to '%s'"):format(vocal, accented)})
end

-- Compound ---------------------------
map("i", "@-", "---------------------------------------------------------------------------", {desc = "--…"})
map("i", "@=", "===========================================================================", {desc = "==…"})
map("i", "@#", "###########################################################################", {desc = "##…"})

map("i", "^l<Enter>", "|", {desc = "|"})
map("i", "^-", "~", {desc = "~"})
map("i", "^>", "=>", {desc = "=>"})
map("i", "^{", "{}", {desc = "{}"})
map("i", "^[", "[]", {desc = "[]"})
map("i", "^(", "()", {desc = "()"})
map("i", "^!", "!==", {desc = "!=="})
map("i", "^=", "===", {desc = "==="})
map("i", "^#p", "###", {desc = "###"})
map("i", "^#n", "#[ #]", {desc = "#[ #]"})
map("i", "^'", "'''", {desc = "'''"})
map("i", '^"', '"""', {desc = '"""'})
map("i", "^`", "```", {desc = "```"})

map("i", "^$<Enter>", "${_}<left>", {desc = "${_}"})

-- Markdown ---------------------------
map("i", "^mc", "```_```<left><left><left>", {desc = "```_```"})

-- Lua and Nvim -----------------------
map("i", "^lp", "print(_)<left>", {desc = "print(_)"})
map("i", "^vp", "vim.print(_)<left>", {desc = "vim.print(_)"})
map("i", "^vl", "log.info(_)<left>", {desc = "log.info(_)"})

-- Html -------------------------------
map("i", "^ht", "</>", {desc = "</>"})

-- Javascript -------------------------
map("i", "^jc", "console.log(_)<left>", {desc = "Console log"})
map("i", "^jA", "alert(_)<left>", {desc = "Alert"})
map("i", "^ja", "const name = () => {_}<left>", {desc = "Arrow function"})
map("i", "^ji", "import {_} from '_'<left>", {desc = "Import"})

-- React
map("i", "^rc", "className={_}<left>", {desc = "ClassName"})
map("i", "^re", "useEffect(() =><CR>{_}, [])<left><left><left><left><left><left>", {desc = "useEffect"})

-- CSS --------------------------------
map("i", "^co", "* {outline: 1px dashed blue;}", {desc = "* {outline: … }"})

-- Php --------------------------------
map("i", "^pb", "<?php<CR>?><left><left>", {desc = "<?php _?>"})
map("i", "^pi", "<?_?><left><left>", {desc = "<?_?>"})

