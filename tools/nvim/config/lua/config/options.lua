vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.updatetime = 500

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
vim.keymap.set("v", "<leader>cs", ":sort<CR>")
vim.keymap.set('v', '<leader>cu', function()
  local uuid = vim.fn.system('uuidgen'):gsub('\n', '')
  vim.cmd('normal! c' .. uuid .. '\x1b')
end, { desc = 'Replace with UUID' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, { desc = '[D]iagnositcs Up' })
vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, { desc = '[D]iagnositcs Down' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = '[D]iagnositcs Float' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = '[D]iagnositcs List' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Left Window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Right Window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Down Window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Up Window' })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 and vim.fn.filereadable("README.md") == 1 then
			vim.cmd("edit README.md")
		end
	end,
})
