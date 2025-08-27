-- lua/plugins/colors.lua
local M = {}

function M.apply()
	local set = vim.api.nvim_set_hl

	-- Tree-sitter token colors (adjust hex to taste)
	set(0, "@variable", { fg = "#689d6a" })
	set(0, "@keyword", { fg = "#8ec07c", bold = true })
	set(0, "@keyword.modifier", { fg = "#fb4934", bold = true })
	set(0, "@keyword.conditional", { fg = "#cc241d", italic = true })
	set(0, "@variable.member", { fg = "#458588" })
	set(0, "@namespace", { fg = "#83a598" })
	set(0, "@parameter", { fg = "#ebdbb2", italic = true })
	set(0, "@property", { fg = "#56b6c2" })
	set(0, "@constant", { fg = "#d65d0e", bold = true })
	set(0, "@string", { fg = "#d65d0e" })
	set(0, "@number", { fg = "#fe8019" })
	set(0, "@float", { fg = "#fe8019" })
	set(0, "@type", { fg = "#b8bb26", bold = true }) -- for classes/enums/etc

	-- LSP semantic tokens → link to TS groups above
	set(0, "@lsp.type.variable", { link = "@variable" })
	set(0, "@lsp.type.keyword", {})
	set(0, "@lsp.mod.readonly", { link = "@keyword.modifier" })
	set(0, "@lsp.mod.abstract", { link = "@keyword.modifier" })
	set(0, "@lsp.mod.async", { link = "@keyword.modifier" })

	set(0, "@lsp.type.parameter", { link = "@parameter" })
	set(0, "@lsp.type.property", { link = "@property" })
	set(0, "@lsp.type.field", { link = "@variable.member" })
	set(0, "@lsp.type.enumMember", { link = "@constant" })
	set(0, "@lsp.typemod.variable.readonly", { link = "@constant" })
	set(0, "@lsp.type.class", { link = "@type" })
	set(0, "@lsp.type.struct", { link = "@type" })
	set(0, "@lsp.type.enum", { link = "@type" })
	set(0, "@lsp.type.interface", { link = "@type" })
	set(0, "@lsp.type.namespace", { link = "@namespace" })

	-- Optional: transparent virtual-text backgrounds for diagnostics
	vim.cmd([[
    highlight DiagnosticVirtualTextError guibg=NONE
    highlight DiagnosticVirtualTextWarn  guibg=NONE
    highlight DiagnosticVirtualTextInfo  guibg=NONE
    highlight DiagnosticVirtualTextHint  guibg=NONE
    ]])
end

return M
