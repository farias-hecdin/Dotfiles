local M = {}

M.lsp = function(lsp_server)
  local lspconfig = require("lspconfig")
  local i = 0

  while (i < #lsp_server) do
    -- Install with: pnpm i -g emmet-ls
    if (lsp_server[i] == "emmet_ls") then
      lspconfig['emmet_ls'].setup({
        filetypes = {"astro", "html", "javascriptreact", "svelte", "svg", "typescriptreact", "vue"},
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        }
      })
    end
    i = i + 1
  end
end

return M
