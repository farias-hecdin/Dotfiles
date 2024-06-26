local M = {}

M.convert_british_color = function(color_name)
  local color_codes = {
    ["colour0"] = "#000000", ["colour1"] = "#800000", ["colour2"] = "#008000", ["colour3"] = "#808000",
    ["colour4"] = "#000080", ["colour5"] = "#800080", ["colour6"] = "#008080", ["colour7"] = "#c0c0c0",
    ["colour8"] = "#808080", ["colour9"] = "#ff0000", ["colour10"] = "#00ff00", ["colour11"] = "#ffff00",
    ["colour12"] = "#0000ff", ["colour13"] = "#ff00ff", ["colour14"] = "#00ffff", ["colour15"] = "#ffffff",
    ["colour16"] = "#000000", ["colour17"] = "#00005f", ["colour18"] = "#000087", ["colour19"] = "#0000af",
    ["colour20"] = "#0000d7", ["colour21"] = "#0000ff", ["colour22"] = "#005f00", ["colour23"] = "#005f5f",
    ["colour24"] = "#005f87", ["colour25"] = "#005faf", ["colour26"] = "#005fd7", ["colour27"] = "#005fff",
    ["colour28"] = "#008700", ["colour29"] = "#00875f", ["colour30"] = "#008787", ["colour31"] = "#0087af",
    ["colour32"] = "#0087d7", ["colour33"] = "#0087ff", ["colour34"] = "#00af00", ["colour35"] = "#00af5f",
    ["colour36"] = "#00af87", ["colour37"] = "#00afaf", ["colour38"] = "#00afd7", ["colour39"] = "#00afff",
    ["colour40"] = "#00d700", ["colour41"] = "#00d75f", ["colour42"] = "#00d787", ["colour43"] = "#00d7af",
    ["colour44"] = "#00d7d7", ["colour45"] = "#00d7ff", ["colour46"] = "#00ff00", ["colour47"] = "#00ff5f",
    ["colour48"] = "#00ff87", ["colour49"] = "#00ffaf", ["colour50"] = "#00ffd7", ["colour51"] = "#00ffff",
    ["colour52"] = "#5f0000", ["colour53"] = "#5f005f", ["colour54"] = "#5f0087", ["colour55"] = "#5f00af",
    ["colour56"] = "#5f00d7", ["colour57"] = "#5f00ff", ["colour58"] = "#5f5f00", ["colour59"] = "#5f5f5f",
    ["colour60"] = "#5f5f87", ["colour61"] = "#5f5faf", ["colour62"] = "#5f5fd7", ["colour63"] = "#5f5fff",
    ["colour64"] = "#5f8700", ["colour65"] = "#5f875f", ["colour66"] = "#5f8787", ["colour67"] = "#5f87af",
    ["colour68"] = "#5f87d7", ["colour69"] = "#5f87ff", ["colour70"] = "#5faf00", ["colour71"] = "#5faf5f",
    ["colour72"] = "#5faf87", ["colour73"] = "#5fafaf", ["colour74"] = "#5fafd7", ["colour75"] = "#5fafff",
    ["colour76"] = "#5fd700", ["colour77"] = "#5fd75f", ["colour78"] = "#5fd787", ["colour79"] = "#5fd7af",
    ["colour80"] = "#5fd7d7", ["colour81"] = "#5fd7ff", ["colour82"] = "#5fff00", ["colour83"] = "#5fff5f",
    ["colour84"] = "#5fff87", ["colour85"] = "#5fffaf", ["colour86"] = "#5fffd7", ["colour87"] = "#5fffff",
    ["colour88"] = "#870000", ["colour89"] = "#87005f", ["colour90"] = "#870087", ["colour91"] = "#8700af",
    ["colour92"] = "#8700d7", ["colour93"] = "#8700ff", ["colour94"] = "#875f00", ["colour95"] = "#875f5f",
    ["colour96"] = "#875f87", ["colour97"] = "#875faf", ["colour98"] = "#875fd7", ["colour99"] = "#875fff",
    ["colour100"] = "#878700", ["colour101"] = "#87875f", ["colour102"] = "#878787", ["colour103"] = "#8787af",
    ["colour104"] = "#8787d7", ["colour105"] = "#8787ff", ["colour106"] = "#87af00", ["colour107"] = "#87af5f",
    ["colour108"] = "#87af87", ["colour109"] = "#87afaf", ["colour110"] = "#87afd7", ["colour111"] = "#87afff",
    ["colour112"] = "#87d700", ["colour113"] = "#87d75f", ["colour114"] = "#87d787", ["colour115"] = "#87d7af",
    ["colour116"] = "#87d7d7", ["colour117"] = "#87d7ff", ["colour118"] = "#87ff00", ["colour119"] = "#87ff5f",
    ["colour120"] = "#87ff87", ["colour121"] = "#87ffaf", ["colour122"] = "#87ffd7", ["colour123"] = "#87ffff",
    ["colour124"] = "#af0000", ["colour125"] = "#af005f", ["colour126"] = "#af0087", ["colour127"] = "#af00af",
    ["colour128"] = "#af00d7", ["colour129"] = "#af00ff", ["colour130"] = "#af5f00", ["colour131"] = "#af5f5f",
    ["colour132"] = "#af5f87", ["colour133"] = "#af5faf", ["colour134"] = "#af5fd7", ["colour135"] = "#af5fff",
    ["colour136"] = "#af8700", ["colour137"] = "#af875f", ["colour138"] = "#af8787", ["colour139"] = "#af87af",
    ["colour140"] = "#af87d7", ["colour141"] = "#af87ff", ["colour142"] = "#afaf00", ["colour143"] = "#afaf5f",
    ["colour144"] = "#afaf87", ["colour145"] = "#afafaf", ["colour146"] = "#afafd7", ["colour147"] = "#afafff",
    ["colour148"] = "#afd700", ["colour149"] = "#afd75f", ["colour150"] = "#afd787", ["colour151"] = "#afd7af",
    ["colour152"] = "#afd7d7", ["colour153"] = "#afd7ff", ["colour154"] = "#afff00", ["colour155"] = "#afff5f",
    ["colour156"] = "#afff87", ["colour157"] = "#afffaf", ["colour158"] = "#afffd7", ["colour159"] = "#afffff",
    ["colour160"] = "#d70000", ["colour161"] = "#d7005f", ["colour162"] = "#d70087", ["colour163"] = "#d700af",
    ["colour164"] = "#d700d7", ["colour165"] = "#d700ff", ["colour166"] = "#d75f00", ["colour167"] = "#d75f5f",
    ["colour168"] = "#d75f87", ["colour169"] = "#d75faf", ["colour170"] = "#d75fd7", ["colour171"] = "#d75fff",
    ["colour172"] = "#d78700", ["colour173"] = "#d7875f", ["colour174"] = "#d78787", ["colour175"] = "#d787af",
    ["colour176"] = "#d787d7", ["colour177"] = "#d787ff", ["colour178"] = "#d7af00", ["colour179"] = "#d7af5f",
    ["colour180"] = "#d7af87", ["colour181"] = "#d7afaf", ["colour182"] = "#d7afd7", ["colour183"] = "#d7afff",
    ["colour184"] = "#d7d700", ["colour185"] = "#d7d75f", ["colour186"] = "#d7d787", ["colour187"] = "#d7d7af",
    ["colour188"] = "#d7d7d7", ["colour189"] = "#d7d7ff", ["colour190"] = "#d7ff00", ["colour191"] = "#d7ff5f",
    ["colour192"] = "#d7ff87", ["colour193"] = "#d7ffaf", ["colour194"] = "#d7ffd7", ["colour195"] = "#d7ffff",
    ["colour196"] = "#ff0000", ["colour197"] = "#ff005f", ["colour198"] = "#ff0087", ["colour199"] = "#ff00af",
    ["colour200"] = "#ff00d7", ["colour201"] = "#ff00ff", ["colour202"] = "#ff5f00", ["colour203"] = "#ff5f5f",
    ["colour204"] = "#ff5f87", ["colour205"] = "#ff5faf", ["colour206"] = "#ff5fd7", ["colour207"] = "#ff5fff",
    ["colour208"] = "#ff8700", ["colour209"] = "#ff875f", ["colour210"] = "#ff8787", ["colour211"] = "#ff87af",
    ["colour212"] = "#ff87d7", ["colour213"] = "#ff87ff", ["colour214"] = "#ffaf00", ["colour215"] = "#ffaf5f",
    ["colour216"] = "#ffaf87", ["colour217"] = "#ffafaf", ["colour218"] = "#ffafd7", ["colour219"] = "#ffafff",
    ["colour220"] = "#ffd700", ["colour221"] = "#ffd75f", ["colour222"] = "#ffd787", ["colour223"] = "#ffd7af",
    ["colour224"] = "#ffd7d7", ["colour225"] = "#ffd7ff", ["colour226"] = "#ffff00", ["colour227"] = "#ffff5f",
    ["colour228"] = "#ffff87", ["colour229"] = "#ffffaf", ["colour230"] = "#ffffd7", ["colour231"] = "#ffffff",
    ["colour232"] = "#080808", ["colour233"] = "#121212", ["colour234"] = "#1c1c1c", ["colour235"] = "#262626",
    ["colour236"] = "#303030", ["colour237"] = "#3a3a3a", ["colour238"] = "#444444", ["colour239"] = "#4e4e4e",
    ["colour240"] = "#585858", ["colour241"] = "#626262", ["colour242"] = "#6c6c6c", ["colour243"] = "#767676",
    ["colour244"] = "#808080", ["colour245"] = "#8a8a8a", ["colour246"] = "#949494", ["colour247"] = "#9e9e9e",
    ["colour248"] = "#a8a8a8", ["colour249"] = "#b2b2b2", ["colour250"] = "#bcbcbc", ["colour251"] = "#c6c6c6",
    ["colour252"] = "#d0d0d0", ["colour253"] = "#dadada", ["colour254"] = "#e4e4e4", ["colour255"] = "#eeeeee"
  }

  return color_codes[color_name] or "Color not found"
end

return M
