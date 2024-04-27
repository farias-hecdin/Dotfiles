local config = require("sentiment.config")
local Portion = require("sentiment.ui.Portion")
local Pair = require("sentiment.ui.Pair")

local VARIABLE_VIEWPORT = "sentiment.viewport"
local NAMESPACE_PAIR = "sentiment.pair"

local M = {}

---Find a side of a pair.
---
---@param portion Portion `Portion` to look inside of.
---@param reversed boolean Whether to look backwards.
---@return tuple<integer, integer>|nil
---@return string|nil
local function find_side(portion, reversed)
  local remaining = 0

  for cursor, char in portion:iter(reversed) do
    if
      (reversed and config.get_left_by_right or config.get_right_by_left)(char)
      ~= nil
    then
      remaining = remaining + 1
    elseif
      (reversed and config.get_right_by_left or config.get_left_by_right)(char)
      ~= nil
    then
      if remaining == 0 then return cursor, char end
      remaining = remaining - 1
    end
  end

  return nil, nil
end

---Find the other side of a pair.
---
---@param portion Portion `Portion` to look inside of.
---@param left string Left side of the desired pair.
---@param right string Right side of the desired pair.
---@param reversed boolean Whether to look backwards.
---@return tuple<integer, integer>|nil
local function find_other_side(portion, left, right, reversed)
  local remaining = 0

  for cursor, char in portion:iter(reversed) do
    if char == (reversed and right or left) then
      remaining = remaining + 1
    elseif char == (reversed and left or right) then
      if remaining == 0 then return cursor end
      remaining = remaining - 1
    end
  end

  return nil
end

---Find both sides of a pair.
---
---@param portion Portion `Portion` to look inside of.
---@return Pair
local function find_pair(portion)
  local under_cursor = portion:get_current_char()
  local cursor = portion:get_cursor()
  local pair = Pair.new()

  local right = config.get_right_by_left(under_cursor)
  local left = config.get_left_by_right(under_cursor)
  if right ~= nil then
    pair.left = cursor
    pair.right = find_other_side(portion, under_cursor, right, false)
  elseif left ~= nil then
    pair.left = find_other_side(portion, left, under_cursor, true)
    pair.right = cursor
  else
    local found_left = nil
    pair.left, found_left = find_side(portion, true)

    if found_left == nil then
      pair.right = find_side(portion, false)
    else
      local found_right = config.get_right_by_left(found_left)
      ---@cast found_right -nil

      pair.right = find_other_side(portion, found_left, found_right, false)
    end
  end

  return pair
end

---Clear `Pair` highlights.
---
---@param buf? buffer Buffer to be cleared.
function M.clear(buf)
  buf = buf or vim.api.nvim_get_current_buf()

  local ns = vim.api.nvim_create_namespace(NAMESPACE_PAIR)
  local ok, viewport = pcall(vim.api.nvim_buf_get_var, buf, VARIABLE_VIEWPORT)
  if not ok then return end

  vim.api.nvim_buf_clear_namespace(buf, ns, viewport[1] - 1, viewport[2])
end

---Calculate and draw the found `Pair`.
---
---@async
---@param win? window Window to be rendered inside.
---@return timer|nil
function M.render(win)
  win = win or vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)
  if
    not config.is_buffer_included(buf)
    or not config.is_current_mode_included()
  then
    M.clear(buf)
    return
  end

  local prev_cursor = vim.api.nvim_win_get_cursor(win)
  prev_cursor[2] = prev_cursor[2] + 1
  return vim.defer_fn(function()
    if
      not vim.api.nvim_win_is_valid(win)
      or not vim.api.nvim_buf_is_valid(buf)
    then
      return
    end

    local portion = Portion.new(win, config.get_limit())
    local cursor = portion:get_cursor()
    if not vim.deep_equal(cursor, prev_cursor) then return end

    M.clear(buf)
    vim.api.nvim_buf_set_var(
      buf,
      VARIABLE_VIEWPORT,
      { portion:get_top(), portion:get_bottom() }
    )

    find_pair(portion):draw(buf, vim.api.nvim_create_namespace(NAMESPACE_PAIR))
  end, config.get_delay())
end

return M
