local vim = vim

-- Options
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

-- Setup plugins --------------------------------------------------------------

-- MiniNotify
local miniNotify_ok, miniNotify = pcall(require, "mini.notify")
if not miniNotify_ok then
  return
end

miniNotify.setup({
  lsp_progress = {
    enable = false,
  }
})

-- Jstls
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  return
end

local bufnr = vim.api.nvim_get_current_buf()
local java_debug_path = vim.fn.stdpath "data" .. "/mason/packages/java-debug-adapter/"
local jdtls_path = vim.fn.stdpath "data" .. "/mason/packages/jdtls/"

-- INFO: It's annoying to edit the version again and again.
local equinox_path = vim.split(vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/jdtls/plugins/*jar"), "\n")
local equinox_launcher_file = ""
for _, file in pairs(equinox_path) do
  if file:match "launcher_" then
    equinox_launcher_file = file
    break
  end
end

-- Change to one of `linux`, `win` or `mac`. Depending on your system.
if vim.fn.has "mac" == 1 then
  OS_name = "mac"
elseif vim.fn.has "unix" == 1 then
  OS_name = "linux"
elseif vim.fn.has "win32" == 1 then
  OS_name = "win"
else
  vim.notify("Unsupported OS", vim.log.levels.WARN, { title = "Jdtls" })
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_path = vim.fn.stdpath("data") .. "/workspace/"
local workspace_dir = workspace_path .. project_name

local root_markers = {
  ".git",
  "mvnw",
  "gradlew",
  "pom.xml",
  "build.gradle",
  "settings.gradle",
  "build.xml",
}

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "java",
    -- INFO: Depends on if `java` is in your $PATH env variable and if it
    -- points to the right version.
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. jdtls_path .. "/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    -- INFO: This may change in the future, check the documentation
    "-jar",
    equinox_launcher_file,
    -- INFO: This are OS specific settings, check the documentation
    "-configuration",
    jdtls_path .. "config_" .. OS_name,

    "-data",
    workspace_dir,
  },
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root(root_markers),
  -- INFO: Only for "java-debug" users
  --
  -- init_options = {
  --   bundles = {
  --     vim.fn.glob(java_debug_path .. "extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
  --   },
  -- },
  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      signatureHelp = { enabled = true },
      extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      flags = { allow_incremental_sync = true },
    }
  },
}

-- vim.cmd [[
-- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
-- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
-- command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
-- command! -buffer JdtJol lua require('jdtls').jol()
-- command! -buffer JdtBytecode lua require('jdtls').javap()
-- command! -buffer JdtJshell lua require('jdtls').jshell()
-- ]]

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
