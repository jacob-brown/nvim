vim.diagnostic.config({
	virtual_text = {
		prefix = "",
		source = "if_many",
		spacing = 4,
	},

	-- Do NOT show diagnostics in the sign column (gutter)
	signs = false,

	underline = false,

	-- Update diagnostics in insert mode (can be distracting, false is common)
	update_in_insert = false,

	-- Sort diagnostics by severity
	severity_sort = true,
})
