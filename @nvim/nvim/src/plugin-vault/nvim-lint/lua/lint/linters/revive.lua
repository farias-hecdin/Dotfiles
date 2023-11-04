local a='[^:]+:(%d+):(%d+): (.*)'local b={'lnum','col','message'}return{cmd='revive',stdin=false,args={},parser=require('lint.parser').from_pattern(a,b,nil,{['source']='revive'})}
