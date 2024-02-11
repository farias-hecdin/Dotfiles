local M = {}

M.lsp = function(servers)
  local lspconfig = require("lspconfig")

  for _, server in ipairs(servers) do
    -- Install with: pnpm i -g emmet-ls
    if server == "emmet_ls" then
      lspconfig["emmet_ls"].setup(
        {
          filetypes = {
            "astro",
            "html",
            "javascript",
            "javascriptreact",
            "php",
            "svelte",
            "typescriptreact",
            "vue"
          },
          init_options = {
            html = {
              options = {
                ["bem.enabled"] = true
              }
            }
          }
        }
      )
    end
  end
end

return M

