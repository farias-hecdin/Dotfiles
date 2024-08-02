local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: pkg install lua-language-server
    if server == "lua_ls" then
      lspconfig["lua_ls"].setup({
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              -- Get the language server to recognize common globals
              globals = { "vim", "describe", "it", "before_each", "after_each" },
              disable = { "need-check-nil", "lowercase-global", "undefined-global" },
              -- Don't make workspace diagnostic, as it consumes too much CPU and RAM
              workspaceDelay = -1,
            },
            completion = {callSnippet = "Replace"},
            telemetry = {enable = false},
            workspace = {checkThirdParty = false}
          }
        }
      })
    end
  end
end

return M
