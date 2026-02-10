return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "qf",
			callback = function()
				vim.cmd([[
          setlocal signcolumn=no
          setlocal nonumber
          setlocal norelativenumber
          setlocal foldcolumn=0
        ]])
				require("bqf").setup({
					preview = {
						win_height = 12,
						win_width = 60,
						delay_ms = 100,
						border = "rounded",
						wrap = true,
					},
				})
			end,
		})
	end,
}

