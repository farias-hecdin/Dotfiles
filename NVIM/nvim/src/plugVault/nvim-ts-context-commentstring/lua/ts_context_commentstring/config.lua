local a={}a.config={enable_autocmd=true,custom_calculation=nil,commentary_integration={Commentary='gc',CommentaryLine='gcc',ChangeCommentary='cgc',CommentaryUndo='gcu'},languages={astro='<!-- %s -->',c='/* %s */',cpp={__default='// %s',__multiline='/* %s */'},css='/* %s */',cue='// %s',gleam='// %s',glimmer='{{! %s }}',go={__default='// %s',__multiline='/* %s */'},graphql='# %s',haskell='-- %s',handlebars='{{! %s }}',hcl={__default='# %s',__multiline='/* %s */'},html='<!-- %s -->',ini='; %s',lua={__default='-- %s',__multiline='--[[ %s ]]'},nix={__default='# %s',__multiline='/* %s */'},php={__default='// %s',__multiline='/* %s */'},python={__default='# %s',__multiline='""" %s """'},rego='# %s',rescript={__default='// %s',__multiline='/* %s */'},scss={__default='// %s',__multiline='/* %s */'},sh='# %s',bash='# %s',solidity={__default='// %s',__multiline='/* %s */'},sql='-- %s',svelte='<!-- %s -->',terraform={__default='# %s',__multiline='/* %s */'},twig='{# %s #}',typescript={__default='// %s',__multiline='/* %s */'},vim='" %s',vue='<!-- %s -->',zsh='# %s',kotlin={__default='// %s',__multiline='/* %s */'},roc='# %s',tsx={__default='// %s',__multiline='/* %s */',jsx_element='{/* %s */}',jsx_fragment='{/* %s */}',jsx_attribute={__default='// %s',__multiline='/* %s */'},comment={__default='// %s',__multiline='/* %s */'},call_expression={__default='// %s',__multiline='/* %s */'},statement_block={__default='// %s',__multiline='/* %s */'},spread_element={__default='// %s',__multiline='/* %s */'}},templ={__default='// %s',component_block='<!-- %s -->'}},config={}}a.config.languages.javascript=a.config.languages.tsx;function a.update(b)a.config=vim.tbl_deep_extend('force',a.config,b or{})end;function a.is_autocmd_enabled()if vim.g.loaded_commentary==1 then return false end;local c=a.config.enable_autocmd;return c==nil and true or c end;function a.get_languages_config()return vim.tbl_deep_extend('force',a.config.languages,a.config.config)end;return a