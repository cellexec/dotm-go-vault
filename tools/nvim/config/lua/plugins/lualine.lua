return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup({
			options = {
				theme = 'onedark'
			},
			sections = {},
			tabline = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch' },
				lualine_c = { 'filename' },
				lualine_x = { 'searchcount' },
				lualine_y = { 'hostname' },
				lualine_z = { 'lsp_status' },
			},
		})
		vim.opt.showtabline = 2
		vim.opt.laststatus = 0
	end,
}
