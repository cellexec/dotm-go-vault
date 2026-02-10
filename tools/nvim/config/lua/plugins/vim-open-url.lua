-- Open in browser
-- https://github.com/dhruvasagar/vim-open-url
return {
	"dhruvasagar/vim-open-url",
	config = function()
		vim.keymap.set("n", "<leader>bb", "<Plug>(open-url-browser)", { silent = true })

		vim.keymap.set("n", "<leader>bg", function()
			vim.fn["open_url#open"]("https://google.com")
		end, { desc = "Open Google", silent = true })

		vim.keymap.set("n", "<leader>bc", function()
			vim.fn["open_url#open"]("https://chat.openai.com")
		end, { desc = "Open ChatGPT", silent = true })

		vim.keymap.set("n", "<leader>by", function()
			vim.fn["open_url#open"]("https://youtube.com")
		end, { desc = "Open YouTube", silent = true })

		vim.keymap.set("n", "<leader>bv", function()
			vim.fn["open_url#open"]("https://v0.dev")
		end, { desc = "Open v0.dev", silent = true })

		vim.keymap.set("v", "<leader>bg", function()
			-- Save current unnamed register
			local old_reg = vim.fn.getreg("\"")

			-- Yank the selected text into "v
			vim.cmd("normal! \"vy")
			local query = vim.fn.getreg("v")

			-- Restore the unnamed register
			vim.fn.setreg("\"", old_reg)

			if query and #query > 0 then
				vim.fn["open_url#engines#search"]("google", query)
			else
				print("No text selected to search")
			end
		end, { desc = "Google selected text", silent = true })
	end,
}
