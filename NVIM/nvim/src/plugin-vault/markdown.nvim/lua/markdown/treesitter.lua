local a=vim.treesitter;local b={}function b.find_node(c,d)local e=a.get_node(d)while e~=nil and not c(e)do e=e:parent()end;return e end;function b.find_parent(e,c)local f=e:parent()while f~=nil and not c(f)do f=f:parent()end;return f end;function b.find_child(e,c)for g in e:iter_children()do if c(g)then return g end end end;function b.child_count(e,c)local h=0;for g in e:iter_children()do if c(g)then h=h+1 end end;return h end;function b.has_parent_type(e)local i=e:parent()return i and e:type()==i:type()end;function b.spans_parent_range(e,j)local i=e:parent()if i==nil then return false end;local k={e:range()}local l={i:range()}j=j or 1;return k[1]==l[1]and k[3]==l[3]and k[2]==l[2]+j and k[4]==l[4]-j end;function b.find_tree_in_node(m,e)for n,o in pairs(m)do if a.node_contains(e,{o:root():range()})then return o end end end;local function p(q,r,s)for t=s:named_child_count()-1,0,-1 do local g=s:named_child(t)if g:type()==r then local n,u,n,v=g:range()q=string.sub(q,1,u)..string.sub(q,v+1)else q=p(q,r,g)end end;return q end;function b.remove_nodes(q,w,r)local o=a.get_string_parser(q,w):parse()[1]:root()return p(q,r,o)end;return b
