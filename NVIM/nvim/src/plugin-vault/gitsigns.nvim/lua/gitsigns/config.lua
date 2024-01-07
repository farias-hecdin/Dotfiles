local a={Config={DiffOpts={},SignConfig={},watch_gitdir={},current_line_blame_formatter_opts={},current_line_blame_opts={},yadm={},Worktree={}}}local function b(c)if type(c.default)=='function'and c.type~='function'then return c.default()else return c.default end end;local function d()local e={algorithm='myers',internal=false,indent_heuristic=false,vertical=true}local f={['indent-heuristic']='indent_heuristic',internal='internal',iwhite='ignore_whitespace_change',iblank='ignore_blank_lines',iwhiteeol='ignore_whitespace_change_at_eol',iwhiteall='ignore_whitespace'}local g=vim.opt.diffopt:get()for h,i in ipairs(g)do if f[i]then e[f[i]]=true elseif i=='horizontal'then e.vertical=false elseif vim.startswith(i,'algorithm:')then e.algorithm=string.sub(i,('algorithm:'):len()+1)elseif vim.startswith(i,'linematch:')then e.linematch=tonumber(string.sub(i,('linematch:'):len()+1))end end;return e end;a.config=setmetatable({},{__index=function(j,k)if rawget(j,k)==nil then local l=a.schema[k]if not l then return end;rawset(j,k,b(l))if l.refresh then l.refresh(function()rawset(j,k,b(l))end)end end;return rawget(j,k)end})a.schema={signs={type='table',deep_extend=true,default={add={hl='GitSignsAdd',text='┃',numhl='GitSignsAddNr',linehl='GitSignsAddLn'},change={hl='GitSignsChange',text='┃',numhl='GitSignsChangeNr',linehl='GitSignsChangeLn'},delete={hl='GitSignsDelete',text='▁',numhl='GitSignsDeleteNr',linehl='GitSignsDeleteLn'},topdelete={hl='GitSignsTopdelete',text='▔',numhl='GitSignsTopdeleteNr',linehl='GitSignsTopdeleteLn'},changedelete={hl='GitSignsChangedelete',text='~',numhl='GitSignsChangedeleteNr',linehl='GitSignsChangedeleteLn'},untracked={hl='GitSignsUntracked',text='┆',numhl='GitSignsUntrackedNr',linehl='GitSignsUntrackedLn'}},default_help=[[{
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '▁' },
      topdelete    = { text = '▔' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    }]],description=[[
      Configuration for signs:
        • `text` specifies the character to use for the sign.
        • `show_count` to enable showing count of hunk, e.g. number of deleted
          lines.

      The highlights `GitSigns[kind][type]` is used for each kind of sign. E.g.
      'add' signs uses the highlights:
        • `GitSignsAdd`   (for normal text signs)
        • `GitSignsAddNr` (for signs when `config.numhl == true`)
        • `GitSignsAddLn `(for signs when `config.linehl == true`)

      See |gitsigns-highlight-groups|.
    ]]},_signs_staged={type='table',deep_extend=true,default={add={hl='GitSignsStagedAdd',text='┃',numhl='GitSignsStagedAddNr',linehl='GitSignsStagedAddLn'},change={hl='GitSignsStagedChange',text='┃',numhl='GitSignsStagedChangeNr',linehl='GitSignsStagedChangeLn'},delete={hl='GitSignsStagedDelete',text='▁',numhl='GitSignsStagedDeleteNr',linehl='GitSignsStagedDeleteLn'},topdelete={hl='GitSignsStagedTopdelete',text='▔',numhl='GitSignsStagedTopdeleteNr',linehl='GitSignsStagedTopdeleteLn'},changedelete={hl='GitSignsStagedChangedelete',text='~',numhl='GitSignsStagedChangedeleteNr',linehl='GitSignsStagedChangedeleteLn'}},default_help=[[{
      add          = { text = '┃' },
      change       = { text = '┃' },
      delete       = { text = '▁' },
      topdelete    = { text = '▔' },
      changedelete = { text = '~' },
    }]],description=[[
    Configuration for signs of staged hunks.

    See |gitsigns-config-signs|.
    ]]},_signs_staged_enable={type='boolean',default=false,description=[[
    Show signs for staged hunks.

    When enabled the signs defined in |git-config-signs_staged|` are used.
    ]]},worktrees={type='table',default=nil,description=[[
      Detached working trees.

      Array of tables with the keys `gitdir` and `toplevel`.

      If normal attaching fails, then each entry in the table is attempted
      with the work tree details set.

      Example: >lua
        worktrees = {
          {
            toplevel = vim.env.HOME,
            gitdir = vim.env.HOME .. '/projects/dotfiles/.git'
          }
        }
    ]]},_on_attach_pre={type='function',default=nil,description=[[
      Asynchronous hook called before attaching to a buffer. Mainly used to
      configure detached worktrees.

      This callback must call its callback argument. The callback argument can
      accept an optional table argument with the keys: 'gitdir' and 'toplevel'.

      Example: >lua
      on_attach_pre = function(bufnr, callback)
        ...
        callback {
          gitdir = ...,
          toplevel = ...
        }
      end
      <
    ]]},on_attach={type='function',default=nil,description=[[
      Callback called when attaching to a buffer. Mainly used to setup keymaps.
      The buffer number is passed as the first argument.

      This callback can return `false` to prevent attaching to the buffer.

      Example: >lua
        on_attach = function(bufnr)
          if vim.api.nvim_buf_get_name(bufnr):match(<PATTERN>) then
            -- Don't attach to specific buffers whose name matches a pattern
            return false
          end

          -- Setup keymaps
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', {})
          ... -- More keymaps
        end
<
    ]]},watch_gitdir={type='table',deep_extend=true,default={enable=true,follow_files=true},description=[[
      When opening a file, a libuv watcher is placed on the respective
      `.git` directory to detect when changes happen to use as a trigger to
      update signs.

      Fields: ~
        • `enable`:
            Whether the watcher is enabled.

        • `follow_files`:
            If a file is moved with `git mv`, switch the buffer to the new location.
    ]]},sign_priority={type='number',default=6,description=[[
      Priority to use for signs.
    ]]},signcolumn={type='boolean',default=true,description=[[
      Enable/disable symbols in the sign column.

      When enabled the highlights defined in `signs.*.hl` and symbols defined
      in `signs.*.text` are used.
    ]]},numhl={type='boolean',default=false,description=[[
      Enable/disable line number highlights.

      When enabled the highlights defined in `signs.*.numhl` are used. If
      the highlight group does not exist, then it is automatically defined
      and linked to the corresponding highlight group in `signs.*.hl`.
    ]]},linehl={type='boolean',default=false,description=[[
      Enable/disable line highlights.

      When enabled the highlights defined in `signs.*.linehl` are used. If
      the highlight group does not exist, then it is automatically defined
      and linked to the corresponding highlight group in `signs.*.hl`.
    ]]},show_deleted={type='boolean',default=false,description=[[
      Show the old version of hunks inline in the buffer (via virtual lines).

      Note: Virtual lines currently use the highlight `GitSignsDeleteVirtLn`.
    ]]},diff_opts={type='table',deep_extend=true,refresh=function(m)vim.api.nvim_create_autocmd('OptionSet',{group=vim.api.nvim_create_augroup('gitsigns.config.diff_opts',{}),pattern='diffopt',callback=m})end,default=d,default_help="derived from 'diffopt'",description=[[
      Diff options. If the default value is used, then changes to 'diffopt' are
      automatically applied.

      Fields: ~
        • algorithm: string
            Diff algorithm to use. Values:
            • "myers"      the default algorithm
            • "minimal"    spend extra time to generate the
                           smallest possible diff
            • "patience"   patience diff algorithm
            • "histogram"  histogram diff algorithm
        • internal: boolean
            Use Neovim's built in xdiff library for running diffs.
        • indent_heuristic: boolean
            Use the indent heuristic for the internal
            diff library.
        • vertical: boolean
            Start diff mode with vertical splits.
        • linematch: integer
            Enable second-stage diff on hunks to align lines.
            Requires `internal=true`.
       • ignore_blank_lines: boolean
            Ignore changes where lines are blank.
       • ignore_whitespace_change: boolean
            Ignore changes in amount of white space.
            It should ignore adding trailing white space,
            but not leading white space.
       • ignore_whitespace: boolean
           Ignore all white space changes.
       • ignore_whitespace_change_at_eol: boolean
            Ignore white space changes at end of line.
    ]]},base={type='string',default=nil,default_help='index',description=[[
      The object/revision to diff against.
      See |gitsigns-revision|.
    ]]},count_chars={type='table',default={[1]='1',[2]='2',[3]='3',[4]='4',[5]='5',[6]='6',[7]='7',[8]='8',[9]='9',['+']='>'},description=[[
      The count characters used when `signs.*.show_count` is enabled. The
      `+` entry is used as a fallback. With the default, any count outside
      of 1-9 uses the `>` character in the sign.

      Possible use cases for this field:
        • to specify unicode characters for the counts instead of 1-9.
        • to define characters to be used for counts greater than 9.
    ]]},status_formatter={type='function',default=function(n)local o,p,q=n.added,n.changed,n.removed;local r={}if o and o>0 then table.insert(r,'+'..o)end;if p and p>0 then table.insert(r,'~'..p)end;if q and q>0 then table.insert(r,'-'..q)end;return table.concat(r,' ')end,default_help=[[function(status)
      local added, changed, removed = status.added, status.changed, status.removed
      local status_txt = {}
      if added   and added   > 0 then table.insert(status_txt, '+'..added  ) end
      if changed and changed > 0 then table.insert(status_txt, '~'..changed) end
      if removed and removed > 0 then table.insert(status_txt, '-'..removed) end
      return table.concat(status_txt, ' ')
    end]],description=[[
      Function used to format `b:gitsigns_status`.
    ]]},max_file_length={type='number',default=40000,description=[[
      Max file length (in lines) to attach to.
    ]]},preview_config={type='table',deep_extend=true,default={border='single',style='minimal',relative='cursor',row=0,col=1},description=[[
      Option overrides for the Gitsigns preview window. Table is passed directly
      to `nvim_open_win`.
    ]]},auto_attach={type='boolean',default=true,description=[[
      Automatically attach to files.
    ]]},attach_to_untracked={type='boolean',default=true,description=[[
      Attach to untracked files.
    ]]},update_debounce={type='number',default=100,description=[[
      Debounce time for updates (in milliseconds).
    ]]},current_line_blame={type='boolean',default=false,description=[[
      Adds an unobtrusive and customisable blame annotation at the end of
      the current line.

      The highlight group used for the text is `GitSignsCurrentLineBlame`.
    ]]},current_line_blame_opts={type='table',deep_extend=true,default={virt_text=true,virt_text_pos='eol',virt_text_priority=100,delay=1000},description=[[
      Options for the current line blame annotation.

      Fields: ~
        • virt_text: boolean
          Whether to show a virtual text blame annotation.
        • virt_text_pos: string
          Blame annotation position. Available values:
            `eol`         Right after eol character.
            `overlay`     Display over the specified column, without
                          shifting the underlying text.
            `right_align` Display right aligned in the window.
        • delay: integer
          Sets the delay (in milliseconds) before blame virtual text is
          displayed.
        • ignore_whitespace: boolean
          Ignore whitespace when running blame.
        • virt_text_priority: integer
          Priority of virtual text.
    ]]},current_line_blame_formatter_opts={type='table',deep_extend=true,deprecated=true,default={relative_time=false},description=[[
      Options for the current line blame annotation formatter.

      Fields: ~
        • relative_time: boolean
    ]]},current_line_blame_formatter={type={'string','function'},default=' <author>, <author_time> - <summary> ',description=[[
      String or function used to format the virtual text of
      |gitsigns-config-current_line_blame|.

      When a string, accepts the following format specifiers:

          • `<abbrev_sha>`
          • `<orig_lnum>`
          • `<final_lnum>`
          • `<author>`
          • `<author_mail>`
          • `<author_time>` or `<author_time:FORMAT>`
          • `<author_tz>`
          • `<committer>`
          • `<committer_mail>`
          • `<committer_time>` or `<committer_time:FORMAT>`
          • `<committer_tz>`
          • `<summary>`
          • `<previous>`
          • `<filename>`

        For `<author_time:FORMAT>` and `<committer_time:FORMAT>`, `FORMAT` can
        be any valid date format that is accepted by `os.date()` with the
        addition of `%R` (defaults to `%Y-%m-%d`):

          • `%a`  abbreviated weekday name (e.g., Wed)
          • `%A`  full weekday name (e.g., Wednesday)
          • `%b`  abbreviated month name (e.g., Sep)
          • `%B`  full month name (e.g., September)
          • `%c`  date and time (e.g., 09/16/98 23:48:10)
          • `%d`  day of the month (16) [01-31]
          • `%H`  hour, using a 24-hour clock (23) [00-23]
          • `%I`  hour, using a 12-hour clock (11) [01-12]
          • `%M`  minute (48) [00-59]
          • `%m`  month (09) [01-12]
          • `%p`  either "am" or "pm" (pm)
          • `%S`  second (10) [00-61]
          • `%w`  weekday (3) [0-6 = Sunday-Saturday]
          • `%x`  date (e.g., 09/16/98)
          • `%X`  time (e.g., 23:48:10)
          • `%Y`  full year (1998)
          • `%y`  two-digit year (98) [00-99]
          • `%%`  the character `%´
          • `%R`  relative (e.g., 4 months ago)

      When a function:
        Parameters: ~
          {name}       Git user name returned from `git config user.name` .
          {blame_info} Table with the following keys:
                         • `abbrev_sha`: string
                         • `orig_lnum`: integer
                         • `final_lnum`: integer
                         • `author`: string
                         • `author_mail`: string
                         • `author_time`: integer
                         • `author_tz`: string
                         • `committer`: string
                         • `committer_mail`: string
                         • `committer_time`: integer
                         • `committer_tz`: string
                         • `summary`: string
                         • `previous`: string
                         • `filename`: string
                         • `boundary`: true?

                       Note that the keys map onto the output of:
                         `git blame --line-porcelain`

          {opts}       Passed directly from
                       |gitsigns-config-current_line_blame_formatter_opts|.

        Return: ~
          The result of this function is passed directly to the `opts.virt_text`
          field of |nvim_buf_set_extmark| and thus must be a list of
          [text, highlight] tuples.
    ]]},current_line_blame_formatter_nc={type={'string','function'},default=' <author>',description=[[
      String or function used to format the virtual text of
      |gitsigns-config-current_line_blame| for lines that aren't committed.

      See |gitsigns-config-current_line_blame_formatter| for more information.
    ]]},trouble={type='boolean',default=function()local s=pcall(require,'trouble')return s end,default_help='true if installed',description=[[
      When using setqflist() or setloclist(), open Trouble instead of the
      quickfix/location list window.
    ]]},yadm={type='table',default={enable=false},description=[[
      yadm configuration.
    ]]},_git_version={type='string',default='auto',description=[[
      Version of git available. Set to 'auto' to automatically detect.
    ]]},_verbose={type='boolean',default=false,description=[[
      More verbose debug message. Requires debug_mode=true.
    ]]},_test_mode={description='Enable test mode',type='boolean',default=false},word_diff={type='boolean',default=false,description=[[
      Highlight intra-line word differences in the buffer.
      Requires `config.diff_opts.internal = true` .

      Uses the highlights:
        • For word diff in previews:
          • `GitSignsAddInline`
          • `GitSignsChangeInline`
          • `GitSignsDeleteInline`
        • For word diff in buffer:
          • `GitSignsAddLnInline`
          • `GitSignsChangeLnInline`
          • `GitSignsDeleteLnInline`
        • For word diff in virtual lines (e.g. show_deleted):
          • `GitSignsAddVirtLnInline`
          • `GitSignsChangeVirtLnInline`
          • `GitSignsDeleteVirtLnInline`
    ]]},_refresh_staged_on_update={type='boolean',default=false,description=[[
      Always refresh the staged file on each update. Disabling this will cause
      the staged file to only be refreshed when an update to the index is
      detected.
    ]]},_threaded_diff={type='boolean',default=true,description=[[
      Run diffs on a separate thread
    ]]},_inline2={type='boolean',default=true,description=[[
      Enable enhanced version of preview_hunk_inline()
    ]]},_extmark_signs={type='boolean',default=true,description=[[
      Use extmarks for placing signs.
    ]]},debug_mode={type='boolean',default=false,description=[[
      Enables debug logging and makes the following functions
      available: `dump_cache`, `debug_messages`, `clear_debug`.
    ]]}}local function t(u,...)vim.notify(u:format(...),vim.log.levels.WARN,{title='gitsigns'})end;local function v(w)for k,c in pairs(w)do local x=a.schema[k]if x==nil then t("gitsigns: Ignoring invalid configuration field '%s'",k)elseif x.type then if type(x.type)=='string'then vim.validate({[k]={c,x.type}})end end end end;local function y(z)for k,c in pairs(a.schema)do local A=c.deprecated;if A and z[k]~=nil then if type(A)=='table'then if A.new_field then local B,l=A.new_field:match('(.*)%.(.*)')if B and l then local C=z[B]or{}C[l]=z[k]z[B]=C else z[A.new_field]=z[k]end end;if A.hard then if A.message then t(A.message)elseif A.new_field then t('%s is now deprecated, please use %s',k,A.new_field)else t('%s is now deprecated; ignoring',k)end end end end end end;local function D(k,c,E)local w=a.config;if c.deep_extend then local F=b(c)w[k]=vim.tbl_deep_extend('force',F,E)else w[k]=E end end;function a.build(G)G=G or{}y(G)v(G)for k,c in pairs(a.schema)do if G[k]~=nil then D(k,c,G[k])if c.refresh then c.refresh(function()D(k,c,G[k])end)end end end end;return a
