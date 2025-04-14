local set = vim.keymap.set

-- Disable arrow keys in normal mode
set("n", "<up>", "")
set("n", "<left>", "")
set("n", "<right>", "")
set("n", "<down>", "")

-------------------------------------------------------------------------------
--- visual
-------------------------------------------------------------------------------
-- move lines when highlighted and indent
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move highlighted" })
set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move highlighted" })

-- keep tabbing (v mode)
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-------------------------------------------------------------------------------
--- file navigation
-------------------------------------------------------------------------------
set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
set("n", "\\", ":Neotree toggle<CR>", { silent = true, noremap = true, desc = "tree toggle" })
-------------------------------------------------------------------------------
--- windows
-------------------------------------------------------------------------------

-- navigate windows
set("n", "<M-h>", "<C-w>h")
set("n", "<M-l>", "<C-w>l")
set("n", "<M-j>", "<C-w>j")
set("n", "<M-k>", "<C-w>k")

set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")

-------------------------------------------------------------------------------
--- moving cursor
-------------------------------------------------------------------------------
-- jumping half page keeping cursor in the middle
set("n", "<C-j>", "<C-d>zz")
set("n", "<C-k>", "<C-u>zz")

-- search cursor stays in the middle
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-------------------------------------------------------------------------------
--- copy pasta
-------------------------------------------------------------------------------
-- no overwriting of nvim clipboard
set("x", "<leader>p", [["_dP]], { desc = "paste no overwrite" })
set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank no overwrite" })
set("n", "<leader>Y", [["+Y]], { desc = "yank no overwrite" })
set({ "n", "v" }, "<leader>d", '"_d', { desc = "delete no overwrite" })

-------------------------------------------------------------------------------
--- search and replace
-------------------------------------------------------------------------------

-- Replace all - word that you are currently on
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "in file [s]earch replace" })

-- Forward incremental replace - word that you are currently on (one at a time)
-- period "." to repeat action
set("n", "<leader>sf", "*``cgn", { desc = "[s]earch replace [f]orward" })

-- Backward incremental replace - word that you are currently on (one at a time)
-- period "." to repeat action
set("n", "<leader>sb", "#``cgN", { desc = "[s]earch replace [b]ackward" })

-- Visual mode partial word selection (one at a time)
-- period "." to repeat action
-- map same as forward inc. replace as action is the same
set("x", "<leader>sf", [[y/\V<C-R>=escape(@",'/\')<CR><CR>Ncgn]], { desc = "[s]earch replace [f]orward" })

-- search and replace across workspace
set("n", "<leader>sr", ":GrugFar<CR>", { desc = "[s]earch [r]eplace" })

-------------------------------------------------------------------------------
--- telescope and lsp
-------------------------------------------------------------------------------
set("n", "K", vim.lsp.buf.hover)
set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ction" })

-- To jump back, press <C-t>.
set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "[G]oto [D]efinition" })
set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "[G]oto [R]eferences" })

set("n", "gv", function()
	require("telescope.builtin").lsp_definitions({
		jump_type = "vsplit",
	})
end, { desc = "[G]oto [D]efinition [V]ertical Split" })

-------------------------------------------------------------------------------
--- refactor
-------------------------------------------------------------------------------
set("x", "<leader>re", ":Refactor extract")
set("x", "<leader>rf", ":Refactor extract_to_file ")
set("x", "<leader>rv", ":Refactor extract_var ")
set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
set("n", "<leader>rI", ":Refactor inline_func")
set("n", "<leader>rb", ":Refactor extract_block")
set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-------------------------------------------------------------------------------
--- DAP
-------------------------------------------------------------------------------
set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "[B]reak point" })
set("n", "<leader>dc", ":DapContinue<CR>", { desc = "continue" })
set("n", "<leader>di", ":DapStepInto<CR>", { desc = "step [i]nto" })
set("n", "<leader>do", ":DapStepOver<CR>", { desc = "step [o]ver" })
set("n", "<leader>du", ":DapStepOut<CR>", { desc = "step [u]p and out" })
set("n", "<leader>dr", ":DapRestart<CR>", { desc = "[r]estart" })
set("n", "<leader>dt", ":DapTerminate<CR>", { desc = "[c]lose" })

-- Eval var under cursor
set("n", "<leader>de", function()
	require("dapui").eval(nil, { enter = true })
end, { desc = "[e]valuate" })

-------------------------------------------------------------------------------
--- trouble
-------------------------------------------------------------------------------
set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })

set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
set(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-------------------------------------------------------------------------------
--- misc
-------------------------------------------------------------------------------
set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "[u]ndo tree" })
set("n", "<leader>nn", "<cmd>NoNeckPain<cr>", { desc = "[N]o [N]eck Pain" })

-------------------------------------------------------------------------------
--- code specific remaps
-------------------------------------------------------------------------------

-- golang add if err != nil statement
set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", { desc = "[E]rror =! nil" })
