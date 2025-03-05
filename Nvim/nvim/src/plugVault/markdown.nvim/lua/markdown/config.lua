---@alias MarkdownMapping string|boolean

---@class MappingOpts
---@field inline_surround_toggle MarkdownMapping
---@field inline_surround_toggle_line MarkdownMapping
---@field inline_surround_delete MarkdownMapping
---@field inline_surround_change MarkdownMapping
---@field link_add MarkdownMapping
---@field link_follow MarkdownMapping
---@field go_curr_heading MarkdownMapping
---@field go_parent_heading MarkdownMapping
---@field go_next_heading MarkdownMapping
---@field go_prev_heading MarkdownMapping

---@alias KeyToTxt { key: string , txt: string }

---@class InlineSurroundOpts
---@field emphasis KeyToTxt
---@field strong KeyToTxt
---@field strikethrough KeyToTxt
---@field code KeyToTxt

---@class LinkOpts
---@field paste { enable: boolean }

---@class TocOpts
---@field omit_heading string
---@field omit_section string
---@field markers string[]

---@class FollowHookOpts
---@field dest string
---@field use_default_app boolean|nil

---@class HookOpts
---@field follow_link fun(opts: FollowHookOpts, fallback: fun())|nil

---@class MarkdownConfig
---@field mappings MappingOpts|boolean
---@field inline_surround InlineSurroundOpts
---@field link LinkOpts
---@field toc TocOpts
---@field hooks HookOpts
---@field on_attach fun(bufnr: integer)|nil

---@private
---@class MarkdownConfigWrapper
---@field cfg MarkdownConfig
local MarkdownConfigWrapper = {}
MarkdownConfigWrapper.__index = MarkdownConfigWrapper

---@type MarkdownConfig
local default_cfg = {
	mappings = {
		inline_surround_toggle = "gs",
		inline_surround_toggle_line = "gss",
		inline_surround_delete = "ds",
		inline_surround_change = "cs",
		link_add = "gl",
		link_follow = "gx",
		go_curr_heading = "]c",
		go_parent_heading = "]p",
		go_next_heading = "]]",
		go_prev_heading = "[[",
	},
	inline_surround = {
		emphasis = {
			key = "i",
			txt = "*",
		},
		strong = {
			key = "b",
			txt = "**",
		},
		strikethrough = {
			key = "s",
			txt = "~~",
		},
		code = {
			key = "c",
			txt = "`",
		},
	},
	link = {
		paste = {
			enable = true,
		},
	},
	toc = {
		omit_heading = "toc omit heading",
		omit_section = "toc omit section",
		markers = { "-" },
	},
	hooks = {
		follow_link = nil,
	},
	on_attach = nil,
}

--- Setup config with user options.
---@param cfg? MarkdownConfig
---@return MarkdownConfig
function MarkdownConfigWrapper:setup(cfg)
	if cfg then
		self.cfg = vim.tbl_deep_extend("force", self.cfg, cfg)
	end
	return self.cfg
end

--- Gets the current configuration.
---@return MarkdownConfig
function MarkdownConfigWrapper:get()
	return self.cfg
end

--- Resets the current configuration defaults.
function MarkdownConfigWrapper:reset()
	self.cfg = default_cfg
end

return setmetatable({
	cfg = default_cfg
}, MarkdownConfigWrapper)
