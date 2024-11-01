return {
	"folke/zen-mode.nvim",
	opts = {

		options = {
			ruler = true,
			showcmd = true,
			laststatus = 3, -- enabled
		},
		plugins = {
			tmux = { enabled = true },
			todo = { enabled = true },
			gitsigns = { enabled = true },
		},
	},
}
