local M = {}

M.setup_active_servers = function(activation_map, plugin, capabilities)
  local lspconfig = plugin
  local util = lspconfig.util

  local servers_setup = {
    -- !Install with: pnpm i -g @astrojs/language-server OR :MasonInstall astro
    astro = {
      capabilities = capabilities, -- Asegúrate que 'capabilities' esté definido
      cmd = { 'astro-ls', '--stdio' },
      filetypes = { 'astro' },
      root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
      init_options = {
        typescript = {},
      },
    },
    -- !Install with: pnpm i -g bash-language-server
    bashls = {
      cmd = { 'bash-language-server', 'start' },
      filetypes = { 'bash', 'sh', 'zsh' },
    },
    -- !Install with: pkg install lua-language-server
    lua_ls = {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      settings = {
        Lua = {
          runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
          diagnostics = {
            globals = { "vim", "describe", "it", "before_each", "after_each" },
            disable = { "need-check-nil", "lowercase-global", "undefined-global" },
            workspaceDelay = -1,
          },
          completion = { callSnippet = "Replace" },
          telemetry = { enable = false },
          workspace = { checkThirdParty = false }
        }
      }
    },
    -- !Install with: pnpm i -g emmet-ls
    emmet_ls = {
      filetypes = {"astro", "html", "javascript", "javascriptreact", "php", "svelte", "typescriptreact", "vue"},
      init_options = {
        showAbbreviationSuggestions = true,
        showExpandedAbbreviation = "always",
        html = {
          options = {
            ["bem.enabled"] = true
          }
        }
      }
    },
    -- !Install with: go install golang.org/x/tools/gopls@latest
    gopls = {
      capabilities = capabilities, -- Asegúrate que 'capabilities' esté definido
      cmd = { "/data/data/com.termux/files/home/" .. "go/bin/gopls", "serve" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      filetypes = { "go", "gomod", "gowork", "gotmpl" }
    },
    -- !Install with: pnpm i -g vscode-langservers-extracted
    cssls = {
      cmd = { 'vscode-css-language-server', '--stdio' },
      filetypes = { 'css', 'scss', 'less' },
      settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
      },
    },
    ts_ls = { -- Considera usar 'typescript-language-server' o 'tsserver'
      init_options = { hostInfo = 'neovim' },
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
      root_dir = util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json', '.git'),
      single_file_support = true,
    },
  }

  for _, server_names_list in pairs(activation_map) do
    for _, server_name_to_setup in ipairs(server_names_list) do
      local server_config_data = servers_setup[server_name_to_setup]
      lspconfig[server_name_to_setup].setup(server_config_data)
    end
  end
end

return M
