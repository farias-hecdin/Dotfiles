-- Options

vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.tabstop = 2

-- LSP utils

-- local _jdtls, jdtls = pcall(require, "jdtls")
-- if not _jdtls then
--     return
-- end
--
-- local config = {
--     cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls") },
--     root_dir = vim.fs.dirname(vim.fs.find({".gradlew", ".git", "mvnw"}, {upward = true})[1])
-- }
--
-- jdtls.start_or_attach(config)
