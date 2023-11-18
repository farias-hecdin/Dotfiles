for a in pairs(package.loaded)do if a:match(".*onedark.*")then package.loaded[a]=nil end end;require('onedark').setup()require('onedark').colorscheme()
