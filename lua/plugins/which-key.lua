return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts_extend = { "spec" },
	opts = {
		preset = "helix",
		defaults = {},
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader><tab>", group = "tabs" },
				{ "<leader>c", group = "code" },
				{ "<leader>d", group = "debug" },
				{ "<leader>f", group = "find" },
				{ "<leader>s", group = "search and replace" },
				{ "<leader>r", group = "refactor" },
				{ "<leader>x", group = "diagnostics", icon = { icon = "󱖫 ", color = "green" } },
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "g", group = "goto" },
				{
					"<leader>w",
					group = "windows",
					proxy = "<c-w>",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
				-- hide some of the maps
				{ "<leader>e", hidden = true },
				{ "<leader>a", hidden = true },
				{ "<leader>1", hidden = true },
				{ "<leader>2", hidden = true },
				{ "<leader>3", hidden = true },
				{ "<leader>4", hidden = true },
				{ "<leader>y", hidden = true },
				{ "<leader>Y", hidden = true },
				{ "<leader>u", hidden = true },

				-- cheatsheet
				{ "<leader>?", group = "cheatsheet", icon = { icon = "🕮 ", color = "orange" } },
				{ "<leader>?1", desc = "<C-v> <S-i> = multi line insertion" },
			},
		},
	},
	keys = {
		{
			"<leader>??",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
	},
}
