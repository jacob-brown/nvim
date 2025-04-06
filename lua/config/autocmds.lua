-- start telescope at start
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argv(0) == "" then
			require("telescope.builtin").find_files()
		end
	end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

--fix terraform and hcl comment string
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
	callback = function(ev)
		vim.bo[ev.buf].commentstring = "# %s"
	end,
	pattern = { "terraform", "hcl" },
})

--fix templ and hcl comment string
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("FixTemplCommentString", { clear = true }),
	callback = function(ev)
		vim.bo[ev.buf].commentstring = "<!-- %s -->"
	end,
	pattern = { "templ" },
})

-- HACK:
-- below is trying to fix the go_to_definition for templ files
-- however it doesn't use telescope for any of the go to definitions
-- just uses the vim go_to_definition thus no <c-t>
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "templ" },
	callback = function()
		vim.keymap.set("n", "gdd", function()
			if vim.bo.filetype == "go" then
				vim.lsp.buf.definition({
					on_list = function(options)
						if options == nil or options.items == nil or #options.items == 0 then
							return
						end

						local targetFile = options.items[1].filename
						local prefix = string.match(targetFile, "(.-)_templ%.go$")

						if prefix then
							options.items[1].filename = prefix .. ".templ"
						end

						vim.fn.setqflist({}, " ", options)
						vim.api.nvim_command("cfirst")
					end,
				})
			else
				vim.lsp.buf.definition()
			end
		end, { buffer = true })
	end,
})
