local utils = {};

utils.clamp = function (val, min, max)
	return math.min(math.max(val, min), max);
end

utils.find_attached_wins = function (buf)
	local attached_wins = {};

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win) == buf then
			table.insert(attached_wins, win);
		end
	end

	return attached_wins;
end

utils.get_cursor_range = function (buffer, window)
	local cursor = vim.api.nvim_win_get_cursor(window or 0);
	local lines = vim.api.nvim_buf_line_count(buffer);

	return math.max(0, cursor[1] - 1), math.min(lines, cursor[1]);
end

return utils;
