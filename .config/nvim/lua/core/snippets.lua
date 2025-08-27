-- Custom code snippets for different purposes

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

local function wrap_diagnostic(text, max_width)
	text = (text or ""):gsub("\n", " ") -- start single-line
	local out, line = {}, ""
	for word in text:gmatch("%S+") do
		local candidate = (line == "") and word or (line .. " " .. word)
		if vim.fn.strdisplaywidth(candidate) > max_width then
			table.insert(out, line)
			line = word
		else
			line = candidate
		end
	end
	if line ~= "" then
		table.insert(out, line)
	end
	return table.concat(out, "\n")
end

vim.diagnostic.config({
	virtual_text = false, -- no single-line inline
	virtual_lines = {
		current_line = true, -- keep your setting
		-- optional: prefix = "│ ",
		-- optional: highlight = "DiagnosticVirtualText",
		format = function(d)
			local winw = vim.api.nvim_win_get_width(0)
			local width = math.max(20, math.min(30, winw - 5)) -- clamp to <=30 cols
			local code = d.code and ("[" .. d.code .. "] ") or ""
			return wrap_diagnostic(code .. (d.message or ""), width)
		end,
	},

	underline = false,
	update_in_insert = true,

	-- Float config (note: wrapping is applied below in the open_floating_preview hook)
	float = {
		source = true,
		border = "rounded",
		max_width = 80,
	},
	-- Appearance of diagnostics
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
		},
	},
	-- Make diagnostic background transparent
	on_ready = function()
		vim.cmd("highlight DiagnosticVirtualText guibg=NONE")
	end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Set kitty terminal padding to 0 when in nvim
vim.cmd([[
  augroup kitty_mp
  autocmd!
  au VimLeave * :silent !kitty @ set-spacing padding=default margin=default
  au VimEnter * :silent !kitty @ set-spacing padding=0 margin=0 3 0 3
  augroup END
]])
