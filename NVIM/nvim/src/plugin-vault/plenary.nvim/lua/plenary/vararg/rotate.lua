local a=require"plenary.tbl"local b={}b[1]=function(c)return c end;b[2]=function(c,d)return d,c end;b[3]=function(c,d,e)return d,e,c end;b[4]=function(c,d,e,f)return d,e,f,c end;b[5]=function(c,d,e,f,g)return d,e,f,g,c end;b[6]=function(c,d,e,f,g,h)return d,e,f,g,h,c end;b[7]=function(c,d,e,f,g,h,i)return d,e,f,g,h,i,c end;b[8]=function(c,d,e,f,g,h,i,j)return d,e,f,g,h,i,j,c end;b[9]=function(c,d,e,f,g,h,i,j,k)return d,e,f,g,h,i,j,k,c end;b[10]=function(c,d,e,f,g,h,i,j,k,l)return d,e,f,g,h,i,j,k,l,c end;b[11]=function(c,d,e,f,g,h,i,j,k,l,m)return d,e,f,g,h,i,j,k,l,m,c end;b[12]=function(c,d,e,f,g,h,i,j,k,l,m,n)return d,e,f,g,h,i,j,k,l,m,n,c end;b[13]=function(c,d,e,f,g,h,i,j,k,l,m,n,o)return d,e,f,g,h,i,j,k,l,m,n,o,c end;b[14]=function(c,d,e,f,g,h,i,j,k,l,m,n,o,p)return d,e,f,g,h,i,j,k,l,m,n,o,p,c end;b[15]=function(c,d,e,f,g,h,i,j,k,l,m,n,o,p,q)return d,e,f,g,h,i,j,k,l,m,n,o,p,q,c end;local function r(s,...)local t=select("#",...)+1;local u=a.pack(...)u[t]=s;return a.unpack(u,1,t)end;local function v(w,...)if w==nil or w<1 then return end;return(b[w]or r)(...)end;return v
