local a='(%d+):(%d+)%s+(%w+)%s+(.-)%s+(%S+)$'local b={'lnum','col','severity','message','code'}local c={['error']=vim.diagnostic.severity.ERROR,['warning']=vim.diagnostic.severity.WARN}return{cmd='solhint',stdin=true,args={'stdin'},ignore_exitcode=true,parser=require('lint.parser').from_pattern(a,b,c,{['source']='solhint'})}