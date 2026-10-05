local M = {}

--- Searches for `fname`, walking up the directory tree.
-- @param fname string File name to look for (e.g. "main.css").
-- @param start_dir string Directory to start searching in (must end in "/").
-- @param depth number Max number of directories to check, including start_dir.
-- @return string|nil Path to the file, or nil if it wasn't found.
M.find_file = function(fname, start_dir, depth)
  local dir = start_dir

  for _ = 1, depth do
    local candidate = dir .. fname
    local file = io.open(candidate, "r")
    if file then
      file:close()
      return candidate
    end
    dir = dir .. "../"
  end

  return nil
end

--- Returns the last modification time (seconds) of a file, or nil if it
--- doesn't exist / can't be stat'ed.
M.get_mtime = function(fpath)
  local stat = vim.uv.fs_stat(fpath)
  return stat and stat.mtime.sec or nil
end

return M

