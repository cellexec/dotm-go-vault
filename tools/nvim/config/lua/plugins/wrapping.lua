return {
	"andrewferrier/wrapping.nvim",
	ft = { "markdown" },
	opts = {
		notify_on_switch = false
	},
	config = function(_, opts)
		local wrapping = require("wrapping")
		wrapping.setup(opts)

		-- Only for markdown files
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.opt_local.wrap = true -- ← actually turn on line wrapping
				vim.opt_local.linebreak = true -- ← break at word boundaries nicely
				wrapping.soft_wrap_mode() -- ← configure wrapping.nvim behavior
			end,
		})
	end,
}
