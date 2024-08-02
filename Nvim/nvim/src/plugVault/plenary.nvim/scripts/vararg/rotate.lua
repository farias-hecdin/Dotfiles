[10:0] unexpected symbol '{' near '%'

Error: failed to minify. Make sure the Lua code is valid.
If you think this is a bug in luamin, please report it:
https://github.com/mathiasbynens/luamin/issues/new

Stack trace using luamin@1.0.4 and luaparse@0.2.1:

SyntaxError: [10:0] unexpected symbol '{' near '%'
    at raise (/data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luaparse@0.2.1/node_modules/luaparse/luaparse.js:460:15)
    at unexpected (/data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luaparse@0.2.1/node_modules/luaparse/luaparse.js:512:14)
    at parseAssignmentOrCallStatement (/data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luaparse@0.2.1/node_modules/luaparse/luaparse.js:1595:36)
    at parseStatement (/data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luaparse@0.2.1/node_modules/luaparse/luaparse.js:1316:12)
    at parseBlock (/data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luaparse@0.2.1/node_modules/luaparse/luaparse.js:1271:19)
    at parseChunk (/data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luaparse@0.2.1/node_modules/luaparse/luaparse.js:1248:16)
    at end (/data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luaparse@0.2.1/node_modules/luaparse/luaparse.js:2094:17)
    at parse (/data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luaparse@0.2.1/node_modules/luaparse/luaparse.js:2065:31)
    at minify (/data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luamin@1.0.4/node_modules/luamin/luamin.js:621:6)
    at /data/data/com.termux/files/home/.local/share/pnpm/global/5/.pnpm/luamin@1.0.4/node_modules/luamin/bin/luamin:69:14
