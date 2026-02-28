local map = vim.keymap.set

-- Auto-pairs & Shortcuts (Insert Mode) ---------------------------------------

-- Accented vocals -------------------
local accented_vocals = {
  A = "Á", a = "á",
  E = "É", e = "é",
  I = "Í", i = "í",
  O = "Ó", o = "ó",
  U = "Ú", u = "ú",
}

for vocal, accented in pairs(accented_vocals) do
  map("i", "´" .. vocal, accented, { desc = ("Accent: %s → %s"):format(vocal, accented) })
end

-- Repeated-character lines ----------
local long_lines = {
  ["-"] = "-",
  ["_"] = "_",
  ["="] = "=",
  ["#"] = "#",
}

for key, char in pairs(long_lines) do
  map("i", "@" .. key, string.rep(char, 75), { desc = char:rep(3) .. "…" })
end

-- Triple characters -----------------
local triples = { "=", "#", "'", '"', "`" }

for _, char in ipairs(triples) do
  map("i", "^" .. char, char:rep(3), { desc = "Insert " .. char:rep(3) })
end

-- Special Shortcuts / Snippets
map("i", "%$<CR>", "${_}<Left>",      { desc = "Snippet: ${_}" })
map("i", "%<",     "</><Left><Left>", { desc = "Snippet: <_/>" })
map("i", "%(",     "()<Left>",        { desc = "Snippet: (_)" })
map("i", "%p",     "<??><Left><Left>",{ desc = "Snippet: <?_?>" })
map("i", "%c",     "* { outline: 1px dashed blue; }", { desc = "CSS: debug outline" })

