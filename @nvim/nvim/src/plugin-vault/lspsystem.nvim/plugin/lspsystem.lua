vim.g.lspsystem_version = '0.0.7'

vim.api.nvim_create_user_command('Lspsystem', function(args)
  require('lspsystem.command').load_command(args.fargs[1], args.fargs[2])
end, {
  range = true,
  nargs = '+',
  complete = function(arg)
    local list = require('lspsystem.command').command_list()
    return vim.tbl_filter(function(s)
      return string.match(s, '^' .. arg)
    end, list)
  end,
})

vim.api.nvim_create_user_command('DiagnosticInsertEnable', function()
  require('lspsystem.diagnostic'):on_insert()
end, {})
