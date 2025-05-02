-- lazy.nvim configuration for nvim-ufo
return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		config = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true

			-- Key mappings for ufo
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

			-- Option 1: coc.nvim as LSP client
			-- use {'neoclide/coc.nvim', branch = 'master', run = 'yarn install --frozen-lockfile'}
			-- require('ufo').setup()

			-- Option 2: nvim lsp as LSP client
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities.textDocument.foldingRange = {
			--     dynamicRegistration = false,
			--     lineFoldingOnly = true
			-- }
			-- local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
			-- for _, ls in ipairs(language_servers) do
			--     require('lspconfig')[ls].setup({
			--         capabilities = capabilities
			--         -- you can add other fields for setting up lsp server in this table
			--     })
			-- end
			-- require('ufo').setup()

			-- Option 3: treesitter as a main provider instead
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})

			-- Option 4: disable all providers for all buffers
			-- require('ufo').setup({
			--     provider_selector = function(bufnr, filetype, buftype)
			--         return ''
			--     end
			-- })
		end,
	},
}
