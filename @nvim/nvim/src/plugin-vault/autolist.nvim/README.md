<p align="center">
  <h1 align="center">autolist.nvim</h2>
</p>
<p align="center">
  Automatic list continuation and formatting for neovim, powered by lua
</p>
<p align="center">
  <a href="https://github.com/gaoDean/autolist.nvim/stargazers">
    <img alt="Stars" src="https://img.shields.io/github/stars/gaoDean/autolist.nvim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41"></a>
  <a href="https://github.com/gaoDean/autolist.nvim/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/gaoDean/autolist.nvim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41"></a>
  <a href="https://github.com/gaoDean/autolist.nvim">
    <img alt="Code Size" src="https://img.shields.io/github/languages/code-size/gaoDean/autolist.nvim?color=%23DDB6F2&logo=hackthebox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41"/></a>
</p>

⚠️ If you've just updated the plugin, read over this document to see
what's new. ⚠️

<https://user-images.githubusercontent.com/97860672/193787598-56abba13-3710-43d1-b8b3-4fd81074dbd4.mp4>

# Why autolist.nvim

This question can be interpreted in two ways. Why did I create autolist, and why you should use autolist.

### Why did I create autolist?

It sounds simple, but all I wanted was a list continuation plugin in lua. Bullets.vim works, but it is written in vimscript and is more than a thousand lines long. Needless to say, I couldn't find a suitable one, so I decided to create my own.

### Why use autolist?

`autolist.nvim's` files are relatively small, with the files complete with comments and formatting. It strives to be as minimal as possible, while implementing basic functionality of automatic lists, and implements context aware renumbering/marking of list entries, to take your mind off the formatting, and have it work in the background while you write down your thoughts.

# Features

-   Automatic list continuation
-   Automatic list formatting
-   List recalculation/renumbering
-   Supports checkboxes
-   Supports Roman Numerals
-   Supports custom list markers

# Installation

This is using lazy.nvim, but you can adapt it to other package managers as well:

``` lua
{
    "gaoDean/autolist.nvim",
    ft = {
        "markdown",
        "text",
        "tex",
        "plaintex",
        "norg",
    },
    config = function()
        require("autolist").setup()

        vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
        vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
        -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
        vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
        vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
        vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
        vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
        vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

        -- cycle list types with dot-repeat
        vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
        vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

        -- if you don't want dot-repeat
        -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
        -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

        -- functions to recalculate list on edit
        vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
        vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
        vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
        vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
},
```

# Usage

1.  Type in a list marker (a list marker is just the delimiter used to start the list (`-|+|*` or `1.|2.|3.`)
2.  Type in your content
3.  When you're ready, press `enter` / `return` and a new list entry will be automatically created
4.  If you're cursor is at the end of the line, you can indent your list with tab. When indenting, ordered lists will automatically be reset to one.
5.  Similarly, dedent your list with shift-tab and your *whole line* gets dedented. When dedenting, markers will automatically be changed through context awareness, to the correct marker such that the list continues logically
6.  Lastly, when you're done, pressing `enter` / `return` on an empty list entry will delete it, leaving you with a fresh new sentence.
7.  You can even go back and delete a line. The list will be automatically renumbered.

``` markdown
- [x] checkboxes can be toggled with `:AutolistToggleCheckbox`, which is bound to `return` in normal mode if you used the default mappings

1. [x] these can also be numbered

a) [ ] or these can work too
b) [x] see?

I. Roman numerals are also supported
II. Just press enter, and autolist will do the calculations for you

MX. All the way up
MXI. to infinity
MXII. It really will continue forever
MXIII. -I think

- you can cycle the type of the list with `:AutolistCycleNext` and `:AutolistCyclePrev`
- below is a copy of this list after cycling twice

1. you can cycle the type of the list with `:AutolistCycleNext` and `:AutolistCyclePrev`
2. below is a copy of this list after cycling twice
```

# Configuration

``` lua
local list_patterns = {
    neorg_1 = "%-",
    neorg_2 = "%-%-",
    neorg_3 = "%-%-%-",
    neorg_4 = "%-%-%-%-",
    neorg_5 = "%-%-%-%-%-",
    unordered = "[-+*]", -- - + *
    digit = "%d+[.)]", -- 1. 2. 3.
    ascii = "%a[.)]", -- a) b) c)
    roman = "%u*[.)]", -- I. II. III.
    latex_item = "\\item",
}

local default_config = {
  enabled = true,
  colon = { -- if a line ends in a colon
    indent = true, -- if in list and line ends in `:` then create list
    indent_raw = true, -- above, but doesn't need to be in a list to work
    preferred = "-", -- what the new list starts with (can be `1.` etc)
  },
  cycle = { -- Cycles the list type in order
      "-",   -- whatever you put here will match the first item in your list
      "*",   -- for example if your list started with a `-` it would go to `*`
      "1.",  -- this says that if your list starts with a `*` it would go to `1.`
      "1)",  -- this all leverages the power of recalculate.
      "a)",  -- i spent many hours on that function
      "I.",  -- try it, change the first bullet in a list to `a)`, and press recalculate
  },
  lists = { -- configures list behaviours
    -- Each key in lists represents a filetype.
    -- The value is a table of all the list patterns that the filetype implements.
    -- See how to define your custom list below in the readme.
    -- You must put the file name for the filetype, not the file extension
    -- To get the "file name", it is just =:set filetype?= or =:se ft?=.
    markdown = {
      list_patterns.unordered,
      list_patterns.digit,
      list_patterns.ascii, -- for example this specifies activate the ascii list
      list_patterns.roman, -- type for markdown files.
    },
    text = {
      list_patterns.unordered,
      list_patterns.digit,
      list_patterns.ascii,
      list_patterns.roman,
    },
    norg = {
        list_patterns.neorg_1,
        list_patterns.neorg_2,
        list_patterns.neorg_3,
        list_patterns.neorg_4,
        list_patterns.neorg_5,
    },
    tex = { list_patterns.latex_item },
    plaintex = { list_patterns.latex_item },
  },
  checkbox = {
    left = "%[", -- the left checkbox delimiter (you could change to "%(" for brackets)
    right = "%]", -- the right checkbox delim (same customisation as above)
    fill = "x", -- if you do the above two customisations, your checkbox could be (x) instead of [x]
  },

  -- this is all based on lua patterns, see "Defining custom lists" for a nice article to learn them
}
```

## Mappings

Here are all the public functions:

-   `AutolistNewBullet` : adds a new bullet on the current line
-   `AutolistRecalculate` : recalculates an ordered list
-   `AutolistToggleCheckbox` : toggles a checkbox on the current line
-   `AutolistCycleNext` : cycles the list type forwards according to `config.cycle`
-   `AutolistCyclePrev` : above, but backwards
-   `AutolistTab` : has a special use case where you want to indent the list when you press tab. If you want to indent the list when you press `<c-t>`, you only need to map `<c-t>` to `AutolistRecalculate` because `AutolistTab` basically turns a tab into `<c-t>` with recalculate.
-   `AutolistShiftTab` : same thing as above, used to replicate word processors. Mapping `<s-tab>` to this will convert it into `<c-d>AutolistRecalculate`.

All of the functions described above have lua counterparts which are just snake case versions of the pascal case commands. For example `AutolistNewBullet` has the snake case counterpart `require("autolist").new_bullet()`

There are two special functions for lua: `require("autolist").cycle_next_dr` and `require("autolist").cycle_prev_dr`, which provide dot-repeatable versions of `AutolistCycleNext` and `AutolistCyclePrev`.

## Defining custom lists

In a nutshell, all you need to do is make a lua pattern match that allows autolist to find your new list marker.

[Here's](https://riptutorial.com/lua/example/20315/lua-pattern-matching) a not-bad article on lua patterns, but you can find examples for these patterns in the preloaded patterns section.

Here's how to define your custom list:

``` lua
local my_list_patterns = {
      test = "%a[.)]"
}

require('autolist').setup({
        lists = {
            markdown = {
                "%a[.)]", -- insert your custom lua pattern here
                my_list_patterns.test, -- or use a variable
            },
        },
    }
})
```

Now your lua pattern (in this case `%a[.)]` which matches ascii lists) will be applied to markdown files.

# Other

## Frequently asked questions

Does it have a mapping for toggling a checkbox like bullets.vim has? Yes.

Does it support checkbox lists? Yes.

## Troubleshooting

Found that a plugin breaks when you use autolist? See [#43](https://github.com/gaoDean/autolist.nvim/issues/43). Basically you need to make sure that autolist loads **after** all the other plugins. If that doesn't work, feel free to create a new issue. Also, make sure that the capitalization of your mappings is correct, or autolist won't detect the other plugins (`<cr>` should be `<CR>`).

## Credit

inspired by [this gist](https://gist.github.com/sedm0784/dffda43bcfb4728f8e90)

> "All software adds features until it is annoyingly complicated. It is then replaced by a"simpler" solution which adds features until it is exactly as complicated."

looking for contributors because i have schoolwork which means i sometimes cant keep up with issues
