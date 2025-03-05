" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if v:version < 600
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

" List of highlight variables
let highlight_vars = ['nim_highlight_numbers', 'nim_highlight_builtins', 'nim_highlight_exceptions', 'nim_highlight_space_errors', 'nim_highlight_special_vars']

" Initialize highlight variables if they do not exist
for var in highlight_vars
  if !exists(var)
    execute 'let ' . var . ' = 1'
  endif
endfor

" Set all highlight variables to 1 if nim_highlight_all exists
if exists('nim_highlight_all')
  for var in highlight_vars
    execute 'let ' . var . ' = 1'
  endfor
endif

" Define regions and matches
syn match nimBuiltin "\<[A-Z]\w*"
syn region nimBrackets contained extend keepend matchgroup=Bold start=+\(\\\)\@<!\[+ end=+]\|$+ skip=+\\\s*$\|\(\\\)\@<!\\]+ contains=@tclCommandCluster

" Define keywords
let nimKeywords = ['and', 'asm', 'atomic', 'div', 'bind', 'block', 'break', 'concept', 'const', 'continue', 'converter', 'defer', 'discard', 'discardable', 'distinct', 'do', 'end', 'enum', 'except', 'export', 'finally', 'for', 'from', 'func', 'import', 'interface', 'iterator', 'let', 'macro', 'method', 'mixin', 'not', 'notin', 'or', 'object', 'out', 'proc', 'raise', 'ref', 'return', 'template', 'try', 'tuple', 'type', 'using', 'var', 'vtptr', 'vtref', 'when', 'while', 'with', 'without', 'yield']
for keyword in nimKeywords
  execute 'syn keyword nimKeyword ' . keyword
endfor

" Define exception keywords
let nimExceptions = ['static', 'include', 'addr', 'ptr', 'cast', 'equalmem', 'equalMem', 'alloc', 'alloc0', 'realloc', 'dealloc', 'zeromem', 'zeroMem', 'copymem', 'copyMem', 'movemem', 'moveMem', 'bycopy']
for exception in nimExceptions
  execute 'syn keyword nimException ' . exception
endfor

" Define functions and classes
syn match   nimFunction      "[a-zA-Z_][a-zA-Z0-9_]*\|`.*`" contained
syn match   nimClass         "[a-zA-Z_][a-zA-Z0-9_]*\|`.*`" contained

" Define conditionals and operators
let nimConditionals = ['if', 'elif', 'else', 'case', 'of']
for conditional in nimConditionals
  execute 'syn keyword nimConditional ' . conditional
endfor

syn match nimOperator +[.][.]+
syn match nimOperator "\\>="
syn match nimOperator "[-=+/<>@$~&%|!?^\\]\?="
syn match nimOperator "[-+/<>@$~&%|!?^\\]"
syn match nimOperator "[∙∘×★⊗⊘⊙⊛ ⊠⊡∩∧⊓]" " same priority as * (multiplication)
syn match nimOperator "[±⊕⊖⊞⊟∪∨⊔]" " same priority as + (addition)

" Define comments and TODOs
syn match   nimComment       "#.*$" contains=nimTodo,@Spell
syn region  nimComment       start="#\[" end="\]#" contains=nimTodo,@Spell
syn keyword nimTodo          TODO FIXME XXX contained

" Define booleans and constants
syn keyword nimBoolean       true false
syn match   nimDelimiters      '[{}\[\]()]'
syn match   nimPreCondit     '{\.[a-zA-Z0-9]\+\|\.}'

" Define strings and raw strings
syn region nimString    start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=nimEscape,nimEscapeError,@Spell
syn region nimString    start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=nimEscape,nimEscapeError,@Spell
syn region nimString    start=+"""+ end=+"""+ keepend contains=nimEscape,nimEscapeError,@Spell
syn region nimRawString matchgroup=Normal start=+[rR]"+ end=+"+ skip=+\\\\\|\\"+ contains=@Spell

" Define escapes
syn match nimEscape +\\[abfnrtv'"\\]+ contained
syn match nimEscape "\\\o\{1,3}" contained
syn match nimEscape "\\x\x\{2}" contained
syn match nimEscape "\(\\u\x\{4}\|\\U\x\{8}\)" contained
syn match nimEscape "\\$"

" Define escape errors
syn match nimEscapeError "\\x\x\=\X" display contained

" Others
" syn match   nimRepeat  '\.\k\+'
" syn match   nimRepeat  '\(?:[a-zA-Z]*\.\)\k\+'
" syn match   nimEscape  '[a-zA-Z]\w*\s\?('
" syn region  nimEscape  start=+\k\+(+ skip=+[\w]*+ end=+)+ contains=nimBuiltin,nimKeyword,nimString,nimRawString,nimBoolean,nimOperator
" syn match   nimEscape  '\w*[\(](\s+\n?\w*\s?)[\)]\n?' " TODO

if nim_highlight_numbers == 1
  " numbers (including longs and complex)
  let s:dec_num = '\d%(_?\d)*'
  let s:int_suf = '%(''%(%(i|I|u|U)%(8|16|32|64)|u|U))'
  let s:float_suf = '%(''%(%(f|F)%(32|64|128)?|d|D))'
  let s:exp = '%([eE][+-]?'.s:dec_num.')'
  exe 'syn match nimNumber /\v<0[bB][01]%(_?[01])*%('.s:int_suf.'|'.s:float_suf.')?>/'
  exe 'syn match nimNumber /\v<0[ocC]\o%(_?\o)*%('.s:int_suf.'|'.s:float_suf.')?>/'
  exe 'syn match nimNumber /\v<0[xX]\x%(_?\x)*%('.s:int_suf.'|'.s:float_suf.')?>/'
  exe 'syn match nimNumber /\v<'.s:dec_num.'%('.s:int_suf.'|'.s:exp.'?'.s:float_suf.'?)>/'
  exe 'syn match nimNumber /\v<'.s:dec_num.'\.'.s:dec_num.s:exp.'?'.s:float_suf.'?>/'
  unlet s:dec_num s:int_suf s:float_suf s:exp
endif

if nim_highlight_builtins == 1
  " Builtin functions, types and objects, not really part of the syntax
  let builtin_functions = [
        \ 'BiggestFloat', 'BiggestInt', 'Byte', 'ByteAddress', 'CloseFile', 'CompileDate', 'CompileTime', 'Conversion', 'EndOfFile', 'Endianness', 'File', 'FileHandle', 'FileMode', 'FlushFile', 'GC_Strategy', 'GC_disable', 'GC_disableMarkAndSweep', 'GC_enable', 'GC_enableMarkAndSweep', 'GC_fullCollect', 'GC_getStatistics', 'GC_ref', 'GC_setStrategy', 'GC_unref', 'Natural', 'OpenFile', 'Positive', 'QuitFailure', 'QuitSuccess', 'ReadBytes', 'ReadChars', 'RootObj',
        \ 'abs', 'add', 'addQuitProc', 'addquitproc', 'any', 'array', 'assert', 'auto', 'bool', 'byte', 'card', 'cchar', 'cdouble', 'cfloat', 'char', 'chr', 'chr', 'cint', 'clong', 'clongdouble', 'clonglong', 'copy', 'countdown', 'countup', 'cpuEndian', 'cpuendian', 'cschar', 'cshort', 'csize', 'csize_t', 'cstring', 'cstringArray', 'cuchar', 'cuint', 'culong', 'culonglong', 'cushort', 'dbgLineHook', 'dbglinehook', 'dec', 'defined', 'echo', 'excl', 'expr', 'fileHandle', 'filehandle', 'find', 'float', 'float32', 'float64', 'getCurrentExceptionMsg', 'getFilePos', 'getFileSize', 'getFreeMem', 'getOccupiedMem', 'getRefcount', 'getTotalMem', 'getcurrentexception', 'getfilepos', 'getfilesize', 'getfreemem', 'getoccupiedmem', 'getrefcount', 'gettotalmem', 'high', 'hostCPU', 'hostOS', 'hostcpu', 'hostos', 'inc', 'incl', 'inf', 'int', 'int16', 'int32', 'int64', 'int8', 'isNil', 'isnil', 'items', 'len', 'lines', 'low', 'mapIt', 'max', 'min', 'nan', 'neginf', 'new', 'newSeq', 'newSeqOfCap', 'newSeqWith', 'newString', 'newStringOfCap', 'newseq', 'newstring', 'nimMajor', 'nimMinor', 'nimPatch', 'nimVersion', 'nimmajor', 'nimminor', 'nimpatch', 'nimversion', 'openArray', 'openarray', 'ord', 'pointer', 'pop', 'pred', 'push', 'quit', 'range', 'readBuffer', 'readChar', 'readFile', 'readLine', 'readbuffer', 'readfile', 'readline', 'repeat', 'repr', 'seq', 'seqToPtr', 'seqtoptr', 'set', 'setFilePos', 'setLen', 'setfilepos', 'setlen', 'sizeof', 'stderr', 'stdin', 'stdout', 'stmt', 'string', 'succ', 'swap', 'toBiggestFloat', 'toBiggestInt', 'toFloat', 'toInt', 'toU16', 'toU32', 'toU8', 'tobiggestfloat', 'tobiggestint', 'tofloat', 'toint', 'tou16', 'tou32', 'tou8', 'typed', 'typedesc', 'uint', 'uint16', 'uint32', 'uint64', 'uint8', 'untyped', 'varArgs', 'varargs', 'void', 'write', 'writeBuffer', 'writeBytes', 'writeChars', 'writeLine', 'writeLn', 'writebuffer', 'writebytes', 'writechars', 'writeline', 'writeln', 'ze', 'ze64']
  let custom_types = ['nil', 'i8', 'i16', 'i32', 'i64', 'u8', 'u16', 'u32', 'u64', 'f32', 'f64', 'uP', 'Sz', 'str', 'cstr']
  for keyword in custom_types + builtin_functions
    execute 'syn keyword nimBuiltin ' . keyword
  endfor

  let builtin_keywords = ['define', 'pragma', 'threadvar', 'compiletime', 'passC', 'passL', 'link', 'importc', 'importcpp', 'importjs', 'cdecl', 'inline', 'async', 'await', 'typeof', 'align', 'pure']
  let minc_specials = ['comptime', 'namespace', 'stub', 'readonly', 'noreturn']
  for keyword in builtin_keywords + minc_specials
    execute 'syn keyword nimKeyword ' . keyword
  endfor

  let nimscript_vars = ['author', 'backend', 'bin', 'binDir', 'description', 'installDirs', 'installExt', 'installFiles', 'license', 'packageName', 'requiresData', 'skipDirs', 'skipExt', 'skipFiles', 'srcDir', 'buildCPU', 'version', 'buildOS']
  for keyword in nimscript_vars
    execute 'syn match nimNimscriptVar ' . '"^' . keyword . '\>"'
  endfor

  let nimscript_funcs = ['withDir', 'taskRequires', 'task', 'cp', 'cmpic', 'cpDir', 'cpDir', 'cppDefine', 'delEnv', 'dirExists', 'exec', 'exists', 'existsEnv', 'fileExists', 'findExe', 'getCurrentDir', 'getEnv', 'hint', 'listDirs', 'listFiles', 'mkDir', 'mvDir', 'mvFile', 'nimcacheDir', 'paramCount', 'paramStr', 'patchFile', 'projectDir', 'projectName', 'projectPath', 'putEnv', 'readAllFromStdin', 'readLineFromStdin', 'requires', 'rmDir', 'rmFile', 'selfExe', 'selfExec', 'setCommand', 'switch', 'thisDir', 'toDll', 'toExe', 'warning', 'echo']
  for keyword in nimscript_funcs
    execute 'syn keyword nimFunction ' . keyword
  endfor

  let exceptions = ['calloc', 'malloc', 'free', 'resize', 'memset', 'memcpy', 'memmove']
  for keyword in exceptions
    execute 'syn keyword nimException ' . keyword
  endfor

  " Special matches
  syn match nimBuiltin "\<contains\>"
  syn match nimBuiltin "\zs\s\<\L[a-zA-Z0-9_]\+"
  syn match nimConstructor "\s*[A-Z][a-zA-Z0-9_]\+\ze("
  syn match nimFunction "\.\<[a-zA-Z0-9_]\+\ze("
  syn match nimFunction "\<\l[a-zA-Z0-9_]\+\ze\[T"
  syn match nimFunction "\<\l[a-zA-Z0-9_]\+\ze\*\[T"
  syn match nimFunction "\<\l[a-zA-Z0-9_]\+\ze("
  syn match nimFunction "\<\l[a-zA-Z0-9_]\+\ze\*("
  syn match nimKeyword "\<compile:"
  syn match nimKeyword "\<emit:"
  syn match nimKeyword "\<header:"
  syn match nimKeyword "\<size:"
  syn match nimKeyword "\zs\sin\s"
endif

if nim_highlight_exceptions == 1
  " Builtin Defects and Errors
  let defects = ['Defect', 'ArithmeticDefect', 'DivByZeroDefect', 'OverflowDefect', 'AccessViolationDefect', 'DeadThreadDefect', 'OutOfMemDefect', 'IndexDefect', 'FieldDefect', 'RangeDefect', 'StackOverflowDefect', 'ReraiseDefect', 'AssertionDefect', 'ObjectAssignmentDefect', 'ObjectConversionDefect', 'FloatingPointDefect', 'FloatInvalidOpDefect', 'FloatDivByZeroDefect', 'FloatOverflowDefect', 'FloatUnderflowDefect', 'FloatInexactDefect', 'NilAccessDefect']
  let errors = ['LibraryError', 'ResourceExhaustedError', 'Exception', 'CatchableError', 'IOError', 'EOFError', 'OSError', 'KeyError', 'ValueError']
  for elem in defects + errors
    execute 'syn keyword nimBuiltin ' . elem
  endfor
  " Any User error possible
  syn match nimException '\<[A-Z]\w*Error\>'
  syn match nimException '\<[A-Z]\w*Defect\>'
endif

" Highlight space errors if enabled
if nim_highlight_space_errors == 1
  " Trailing whitespace
  syn match nimSpaceError display excludenl "\S\s\+$"ms=s+1
  " Any tabs are illegal in Nim
  syn match nimSpaceError display "\t"
endif

" Highlight special variables if enabled
if nim_highlight_special_vars
  syn keyword nimSpecialVar result it
endif

" Sync settings
syn sync match nimSync grouphere NONE "):$"
syn sync minlines=2
syn sync maxlines=200

if v:version >= 508 || !exists('did_nim_syn_inits')
  if v:version <= 508
    let did_nim_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " Default highlighting methods
  let highlight_links = [
        \ ['nimBoolean', 'Boolean'],
        \ ['nimBrackets', 'Operator'],
        \ ['nimCharacter', 'Character'],
        \ ['nimComment', 'Comment'],
        \ ['nimConditional', 'Conditional'],
        \ ['nimConstructor', '@constructor'],
        \ ['nimDecorator', 'Define'],
        \ ['nimDelimiters', '@variable'],
        \ ['nimEscape', 'Special'],
        \ ['nimFloat', 'Float'],
        \ ['nimFunction', 'Function'],
        \ ['nimInclude', 'Include'],
        \ ['nimKeyword', 'Keyword'],
        \ ['nimMacro', 'Macro'],
        \ ['nimNimscriptFunc', 'Keyword'],
        \ ['nimNimscriptVar', 'Statement'],
        \ ['nimOperator', 'Repeat'],
        \ ['nimPragma', 'PreProc'],
        \ ['nimPreCondit', '@variable.member'],
        \ ['nimRawString', 'String'],
        \ ['nimRepeat', 'Repeat'],
        \ ['nimSpecialVar', 'Identifier'],
        \ ['nimStatement', 'Statement'],
        \ ['nimString', 'String'],
        \ ['nimStructure', 'Structure'],
        \ ['nimTodo', 'Todo'],
        \ ['nimType', 'Function'],
        \ ]

  for [group, link] in highlight_links
    execute 'HiLink ' . group . ' ' . link
  endfor

  " Conditional highlighting
  if nim_highlight_numbers == 1
    HiLink nimNumber Number
  endif
  if nim_highlight_builtins == 1
    HiLink nimBuiltin Number
  endif
  if nim_highlight_exceptions == 1
    HiLink nimException Exception
  endif
  if nim_highlight_space_errors == 1
    HiLink nimSpaceError Error
  endif

  delcommand HiLink
endif

let b:current_syntax = 'nim'
