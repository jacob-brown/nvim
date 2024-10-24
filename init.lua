-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- on startup display the filetree
--vim.cmd("Ex")

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true


-- [[ load configurations ]]
require('config.remaps')
require('config.options')
require('config.autocmds')
require("config.lazy")



local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-- colour scheme
-- must be called before loading
vim.cmd.colorscheme "catppuccin"


-- harpoon
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-u>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-i>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-o>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-p>", function() harpoon:list():select(4) end)



