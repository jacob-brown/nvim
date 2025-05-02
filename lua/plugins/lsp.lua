--https://www.youtube.com/watch?v=bTWWFQZqzyI&ab_channel=TJDeVries
--
-- :h lspconfig-all
-- and then search for the install instructions
--
-- echo executable('<name of lsp>')
-- echo executable('tailwindcss-language-server')

-- :LazyDev lsp
-- will show which lsps are running, which is helpful for
-- checking things are working as expected!

-- commands like the below allow communication between the lsp and blink
-- require("lspconfig").lua_ls.setup({ capabilites = capabilities })

--
-- if returns 1 nvim can access the lsp

-------------------------------------------------------------------------------
--- UPDATE - not quite functional
-------------------------------------------------------------------------------
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"j-hui/fidget.nvim",
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local cmp = require("cmp")
			local lspconfig = require("lspconfig")
			local lspkind = require("lspkind")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			require("luasnip.loaders.from_vscode").lazy_load()

			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			--------------------------------------------------------------
			-- 0.setup cmp
			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
						-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

						-- For `mini.snippets` users:
						-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
						-- insert({ body = args.body }) -- Insert at cursor
						-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
						-- require("cmp.config").set_onetime({ sources = {} })
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					-- ["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lua" }, -- gives completiond for nvim itself, therefore comes before nvim_lsp
					{ name = "nvim_lsp" },
					{ name = "path" },
					-- { name = "vsnip" }, -- For vsnip users.
					{ name = "luasnip" }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer", keyword_length = 5 },
				}),

				formatting = {
					format = lspkind.cmp_format({
						with_text = true,
						menu = {
							nvim_lua = "[api]",
							nvim_lsp = "[LSP]",
							path = "[path]",
							luasnip = "[snip]",
							buffer = "[buf]",
						},
					}),
				},
			})

			--------------------------------------------------------------
			-- 1. Install the lsp
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"tailwindcss",
					"templ",
					"terraformls",
					"html",
					"htmx",
					"pyright",
				},
				automatic_installation = true,
			})

			--------------------------------------------------------------
			-- 2. attach and config

			--lua
			lspconfig.lua_ls.setup({ capabilites = capabilities })

			--go
			lspconfig.gopls.setup({ capabilites = capabilities })

			-- tailwind
			lspconfig.tailwindcss.setup({ capabilites = capabilities })

			-- templ
			lspconfig.templ.setup({ capabilites = capabilities })

			--terraform
			lspconfig.terraformls.setup({ capabilites = capabilities })
			--TODO: terraform-lsp might be also a good one to install?

			--html
			lspconfig.html.setup({ capabilites = capabilities })

			--htmx
			lspconfig.htmx.setup({ capabilites = capabilities })

			--python
			lspconfig.pyright.setup({ capabilites = capabilities })

			--------------------------------------------------------------
			-- auto format lua
			-- vim.api.nvim_create_autocmd("LspAttach", {
			--     callback = function(args)
			--         local c = vim.lsp.get_client_by_id(args.data.client_id)
			--         if not c then
			--             return
			--         end
			--
			--         if vim.bo.filetype == "lua" then
			--             -- Format the current buffer on save
			--             vim.api.nvim_create_autocmd("BufWritePre", {
			--                 buffer = args.buf,
			--                 callback = function()
			--                     vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
			--                 end,
			--             })
			--         end
			--     end,
			-- })
		end,
	},
}
