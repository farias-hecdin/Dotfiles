local a=[[^(.*):(%d+):(%d+): *%[([0-5])%] (.*)$]]local b={'file','lnum','col','severity','message'}local c={['5']=vim.diagnostic.severity.WARN,['4']=vim.diagnostic.severity.WARN,['3']=vim.diagnostic.severity.WARN,['2']=vim.diagnostic.severity.WARN,['1']=vim.diagnostic.severity.WARN}return{cmd='flawfinder',stdin=false,args={'-S','-Q','-D','-C','--'},stream='stdout',parser=require('lint.parser').from_pattern(a,b,c,{['source']='flawfinder'})}