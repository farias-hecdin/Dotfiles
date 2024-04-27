# bufdelete.nvim

## About

Neovim's default `:bdelete` command can be quite annoying, since it also messes up your entire window layout by deleting windows. bufdelete.nvim aims to fix that by providing useful commands that allow you to delete a buffer without messing up your window layout.

## Requirements

- Latest Neovim stable version.

**NOTE:** The plugin may work on older versions, but it will always be developed with the latest stable version in mind. So if you use a distribution or operating system that has older versions instead of the newest one, either compile the latest version of Neovim from source or use the plugin with the older version at your own risk. Do NOT open any issues if the plugin doesn't work with an older version of Neovim.

## Installation

- [packer.nvim](https://github.com/wbthomason/packer.nvim/):
```
use 'famiu/bufdelete.nvim'
```

- [vim-plug](https://github.com/junegunn/vim-plug/):
```
Plug 'famiu/bufdelete.nvim'
```

## Usage

bufdelete.nvim is quite straightforward to use. It provides two commands, `:Bdelete` and `:Bwipeout`. They work exactly the same as `:bdelete` and `:bwipeout`, except they keep your window layout intact.

There's also two Lua functions provided by bufdelete.nvim, `bufdelete` and `bufwipeout`, which do the same thing as their command counterparts. Both of them take two arguments, `buffers` and `force`. `buffers` is either a single buffer number, buffer name or regexp pattern (e.g. `"foo.txt"`, `"^bar.txt$"`, etc.), or a list of buffer numbers, names or patterns. `force` determines whether to force the deletion or not. A buffer number of 0 represents the current buffer. Moreover, if `buffers` is nil, it also deletes the current buffer.

If deletion isn't being forced, you're instead prompted for action for every modified buffer.

Here's an example of how to use the functions:

```lua
-- Forcibly delete current buffer
require('bufdelete').bufdelete(0, true)

-- Wipeout buffer number 100 without force
require('bufdelete').bufwipeout(100)

-- Delete buffer 7 and 30 without force.
require('bufdelete').bufdelete({7, 30})

-- Delete buffer matching foo.txt with force
require('bufdelete').bufdelete("foo.txt", true)

-- Delete buffer matching foo.txt, buffer matching bar.txt and buffer 3 with force
require('bufdelete').bufdelete({"foo.txt", "bar.txt", 3}, true)
```

## Behavior

By default, when you delete buffers, bufdelete.nvim switches to a different buffer in every window where one of the target buffers was open. If no buffer other than the target buffers was open, bufdelete creates an empty buffer and switches to it instead.

## User autocommands

bufdelete.nvim triggers the following User autocommands (see `:help User` for more information):
- `BDeletePre <buffer>` - Prior to deleting a buffer.
- `BDeletePost <buffer>` - After deleting a buffer.

Note that the autocommands are triggered separately for each buffer. For example, if buffers 1 and 2 are deleted, there will be 2 autocommands for each of `BDeletePre` and `BDeletePost`, and their patterns will be `BDeletePre 1`, `BDeletePre 2` and `BDeletePost 1`, `BDeletePost 2`, respectively.
