local a={}function a.sourced_filepath()local b=debug.getinfo(2,"S").source:sub(2)return b end;function a.sourced_filename()local b=a.sourced_filepath()return b:match"^.*/(.*).lua$"or b end;return a
