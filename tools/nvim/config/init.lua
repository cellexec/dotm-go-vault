require("config.options")
require("config.lazy")
require("config.spell")
require("config.filetypes")

vim.keymap.set('n', '<leader>cn', '<cmd>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '<leader>cp', '<cmd>cprev<CR>', { desc = 'Previous quickfix item' })

vim.opt.cmdheight = 0

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("config") .. "/undodir"
