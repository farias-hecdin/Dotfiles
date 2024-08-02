### Nim language plugin for NeoVim

This plugin is still pretty much a work-in-progress.

![CI](https://github.com/alaviss/nim.nvim/workflows/CI/badge.svg)

[![asciicast](https://asciinema.org/a/223646.svg)](https://asciinema.org/a/223646)

#### Requirements

- neovim >= 0.4.3
- nim >= 0.20 ([choosenim] can be used to install this version)

#### Installation

- [vim-plug]:

      Plug 'alaviss/nim.nvim'

- [vim-packager]:

      call packager#add('alaviss/nim.nvim')

#### Features

- Semantic highlighting with nimsuggest. Highlight as you type (experimental)
- "Go to Definition" support using nimsuggest.
- Autocompletion using nimsuggest.
- Find references to a symbol.
- Get signature and documentation of a symbol.
- Section movements!
- NEP-1 style indentation!
- And more...

#### Auto completion

Install [`prabirshrestha/asyncomplete.vim`][0] and configure it to your liking.

Add this to your configuration file to register the autocomplete source:

```vim
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'nim',
    \ 'whitelist': ['nim'],
    \ 'completor': {opt, ctx -> nim#suggest#sug#GetAllCandidates({start, candidates -> asyncomplete#complete(opt['name'], ctx, start, candidates)})}
    \ })
```

##### Support for different completion plugins

While [`prabirshrestha/asyncomplete.vim`][0] is the most tested plugin for use
with `nim.nvim`, it's worth noting that this plugin was made to support a wide
range of completion plugins.

If your favorite completion plugin supports asynchronous completion sources in
vimscript, the functions in `autoload/nim/suggest/sug.vim` can be used to
integrate nim.nvim with it. Details on how to do so differs between plugins, so
please refer to your completion plugin's documentations.

See [Support for other completion plugins][2] for pre-made configuration
snippets for other plugins.

If you have any questions, you can find me in the [`#nim`] IRC channel
under the handle `leorize`.

#### Usage

See the project's [wiki][1] for more information.

[0]: https://github.com/prabirshrestha/asyncomplete.vim
[1]: https://github.com/alaviss/nim.nvim/wiki
[2]: https://github.com/alaviss/nim.nvim/wiki/Support-for-other-completion-plugins
[choosenim]: https://github.com/dom96/choosenim
[vim-packager]: https://github.com/kristijanhusak/vim-packager
[vim-plug]: https://github.com/junegunn/vim-plug
[`#nim`]: irc://freenode.net/nim
