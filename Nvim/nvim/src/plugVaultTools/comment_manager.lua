local M = {}

function M.read_file(file_to_read)
    local file, err = io.open(file_to_read, "r")
    if not file then
        return nil, "Error opening file: " .. (err or "unknown error")
    end

    local content = file:read("*a")
    file:close()

    if content:match("%@no%-check") then
        return nil, "@no-check found in file"
    end

    return content
end

function M.write_file(file_to_write, content)
    local file, err = io.open(file_to_write, "w")
    if not file then
        return false, "Error creating file: " .. (err or "unknown error")
    end

    file:write(content)
    file:close()
    return true
end

function M.comment_dir_property(enable, path)
    local patterns = {
        comment = {
            search = enable and "[^--]%sdir%s=" or "[^--]%surl%s=",
            replace = enable and "  -- dir =" or "  -- url ="
        },
        uncomment = {
            search = enable and "%s%-%-%s*url" or "%s%-%-%s*dir",
            replace = enable and " url" or " dir"
        }
    }

    local content, err = M.read_file(path)
    if not content then
        print(("⚠️ Skipping '%s': %s"):format(path:match("[^/]+$") or path, err))
        return
    end

    local new_content = content:gsub(patterns.comment.search, patterns.comment.replace)
                              :gsub(patterns.uncomment.search, patterns.uncomment.replace)

    local success, write_err = M.write_file(path, new_content)
    if success then
        print(("✅ Successfully updated: %s"):format(path:match("[^/]+$") or path))
    else
        print(("❌ Failed to update '%s': %s"):format(path:match("[^/]+$") or path, write_err))
    end
end

local function main()
    local function get_valid_input(prompt, options)
        local input
        repeat
            io.write(prompt)
            input = io.read():lower():gsub("%s+", "")
            if not options[input] then
                print("\27[31mInvalid option. Please try again.\27[0m\n")
            end
        until options[input]
        return input
    end

    local function get_file_list(list_file)
        local files = {}
        for line in io.lines(list_file) do
            if line:match("%.lua$") then
                table.insert(files, line)
            end
        end
        return files
    end

    -- Configuración principal
    local FILE_LIST_PATH = "../plugin-setup-files.txt"
    local BASE_PATH = "../../lua/USER/modules/"

    print("1. Deshabilitar 'dir' y habilitar 'url'")
    print("2. Deshabilitar 'url' y habilitar 'dir'")

    local choice = get_valid_input("Seleccione una opción (1/2): ", {["1"]=true, ["2"]=true})
    local enable = (choice == "1")

    local file_list = get_file_list(FILE_LIST_PATH)
    if #file_list == 0 then
        print("\n\27[33mNo se encontraron archivos .lua para procesar.\27[0m")
        return
    end

    print("\n" .. string.rep("-", 50))
    print(("Modo seleccionado: %s"):format(enable and "Habilitar URL" or "Habilitar DIR"))
    print(("Archivos a procesar: %d"):format(#file_list))
    print(("\nIniciando procesamiento...\n"):format(#file_list))

    for _, file in ipairs(file_list) do
        local full_path = BASE_PATH .. file
        M.comment_dir_property(enable, full_path)
    end

    print("\n\27[32mProceso completado. Archivos modificados: " .. #file_list .. "\27[0m")
end

main()

