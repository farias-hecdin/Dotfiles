local a=require"plenary.async_lib.async"local b=vim.loop;local c={}local function d(e,f)local g,h=pcall(a.wrap,b[e],f)if not g then error("Failed to add function with name "..e)end;c[e]=h end;d("close",4)d("fs_open",4)d("fs_read",4)d("fs_close",2)d("fs_unlink",2)d("fs_write",4)d("fs_mkdir",3)d("fs_mkdtemp",2)d("fs_rmdir",2)d("fs_scandir",2)d("fs_stat",2)d("fs_fstat",2)d("fs_lstat",2)d("fs_rename",3)d("fs_fsync",2)d("fs_fdatasync",2)d("fs_ftruncate",3)d("fs_sendfile",5)d("fs_access",3)d("fs_chmod",3)d("fs_fchmod",3)d("fs_utime",4)d("fs_futime",4)d("fs_link",3)d("fs_symlink",4)d("fs_readlink",2)d("fs_realpath",2)d("fs_chown",4)d("fs_fchown",4)d("fs_copyfile",4)d("fs_readdir",2)d("fs_closedir",2)d("shutdown",2)d("listen",3)d("write",3)d("write2",4)d("shutdown",2)d("tcp_connect",4)d("pipe_connect",3)d("udp_send",5)d("udp_recv_start",2)d("getaddrinfo",4)d("getnameinfo",2)return c
