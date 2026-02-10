return {
	"cellexec/tasks.nvim",
	event = "VeryLazy",

	config = function()
		local opts = { noremap = true, silent = true }

		vim.api.nvim_set_keymap("n", "<leader>t", ":lua require('tasks').open_tasks()<CR>", opts)
		vim.api.nvim_set_keymap("n", "<leader>ta", ":lua require('tasks').add_task()<CR>", opts)
		vim.api.nvim_set_keymap("n", "<leader>tr", ":lua require('tasks').remove_task(require('tasks').load_tasks())<CR>",
			opts)
		vim.api.nvim_set_keymap("n", "<leader>te", ":lua require('tasks').edit_task(require('tasks').load_tasks())<CR>",
			opts)
	end
}
