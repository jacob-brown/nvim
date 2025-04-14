-- https://cmp.saghen.dev/configuration/general.html
return {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",

		version = "v0.*",

		opts = {
			keymap = { preset = "default" },
			fuzzy = { implementation = "prefer_rust_with_warning" },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			signature = { enabled = true },
		},
	},
}
