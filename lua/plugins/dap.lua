return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"leoluz/nvim-dap-go",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
			"williamboman/mason.nvim",
		},
		config = function()
			local dap = require("dap")
			local ui = require("dapui")

			require("dapui").setup()
			require("dap-go").setup()

			require("nvim-dap-virtual-text").setup({})

			vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
			vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

			-- Eval var under cursor
			vim.keymap.set("n", "<space>?", function()
				require("dapui").eval(nil, { enter = true })
			end)

			vim.keymap.set("n", "<C-1>", dap.continue)
			vim.keymap.set("n", "<C-2>", dap.step_into)
			vim.keymap.set("n", "<C-3>", dap.step_over)
			vim.keymap.set("n", "<C-4>", dap.step_out)
			vim.keymap.set("n", "<C-5>", dap.step_back)
			vim.keymap.set("n", "<C-6>", dap.restart)
			vim.keymap.set("n", "<C-7>", ui.close) --"<cmd>lua require'dap'.disconnect({ terminateDebuggee = true })<CR>")

			dap.listeners.before.attach.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				ui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				ui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				ui.close()
			end
		end,
	},
}
