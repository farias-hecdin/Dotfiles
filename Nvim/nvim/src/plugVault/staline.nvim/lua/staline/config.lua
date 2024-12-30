local util = require("staline.utils")
local extract_hl = util.extract_hl

return {
    sections = {
        left = { '- ', '-mode', 'left_sep_double', ' ', 'branch' },
        mid  = { 'file_name' },
        right = { 'cool_symbol','right_sep_double', '-line_column' }
    },

    inactive_sections = {
        left = { 'branch' },
        mid  = { 'file_name' },
        right = { 'line_column' }
    },

    lsp_symbols = { Error="󰅙 ", Info="󰋼 ", Warn=" ", Hint="" },

    defaults = {
        left_separator = "",
        right_separator = "",
        line_column = " [%l/%L] :%c 󰕱 %p%% ",
        expand_null_ls = false,
        full_path = false,

        fg = "#000000",
        bg = "none",
        inactive_color = "#303030",
        inactive_bgcolor = "none",
        font_active = "none",          -- bold,italic etc.
        true_colors = false,

        cool_symbol = util.system_icon(),
        branch_symbol = " ",
        mod_symbol = " 󰏫 ",
        lsp_client_symbol = " ",
        lsp_client_character_length = 12,
        null_ls_symbol = "",
    },

    special_table = {
        NvimTree = { 'NvimTree', ' ' },
        packer = { 'Packer',' ' },
        dashboard = { 'Dashboard', '  ' },
        help = { 'Help', '󰗚 ' },
        qf = { "QuickFix", "󱎸 " },
        alpha = { "Alpha", "  " },
        Jaq = { "Jaq", "  "},
        Fm = { "Fm", "  "},
        TelescopePrompt = { 'Telescope', "  " },
    },

    mode_colors = {
        ["n"]  = extract_hl("Function"),
        ["c"]  = extract_hl("Identifier"),
        ["i"]  = extract_hl("Keyword"),
        ['ic'] = extract_hl("Keyword"),
        ['s']  = extract_hl("Keyword"),
        ['S']  = extract_hl("Keyword"),
        ["v"]  = extract_hl("Type"),
        ["V"]  = extract_hl("Type"),
        [''] = extract_hl("Type"),
        ['t']  = extract_hl("Identifier"),
        ['r']  = extract_hl("Statement"),
        ['R']  = extract_hl("Statement")
    },

    mode_icons = {
        ['n']='󰋜 ', ['no']='󰋜 ', ['niI']='󰋜 ', ['niR']='󰋜 ',
        ['no']='󰋜 ', ['niV']='󰋜 ', ['nov']='󰋜 ', ['noV']='󰋜 ',
        ['i']='󰏫 ', ['ic']='󰏫 ', ['ix']='󰏫 ', ['s']='󰏫 ', ['S']='󰏫 ',
        ['v']='󰈈 ', ['V']='󰈈 ', ['']='󰈈 ',
        ['r']='󰛔 ', ['r?']=' ', ['c']=' ',
        ['t']=' ', ['!']=' ', ['R']=' ',
    },

    file_icons = {
        astro='',
        c='',
        clj='',
        conf=' ',
        cpp='',
        cs='󰌛',
        css='',
        d='',
        dart='',
        elm='',
        go='',
        haskell='',
        html='',
        java='',
        js='',
        jsx='',
        tsx='',
        jl='',
        json='󰘦 ',
        kt='',
        lua=' ',
        m='',
        md='󰍔',
        nim='',
        pl='',
        php='󰌟',
        py='',
        r='󰟔',
        rb='󰴭',
        rs='󱘗',
        scala='',
        scss='',
        sh='',
        sql='󰆼',
        sqlite='',
        svelte='',
        swift='󰛥',
        tex='',
        toml='',
        txt='󰦪',
        yaml='󰦪',
        ts='',
        v='',
        vim='',
        vue='󰡄',
        zig='',
        zsh='',
    }
}
