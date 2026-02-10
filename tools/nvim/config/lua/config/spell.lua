-- lua/plugins/spell.lua

-- Helper function: download missing spellfiles
local function ensure_spellfile(lang)
	local spell_dir = vim.fn.stdpath("config") .. "/spell"
	local spell_file = spell_dir .. "/" .. lang .. ".utf-8.spl"

	if vim.fn.filereadable(spell_file) == 0 then
		vim.fn.mkdir(spell_dir, "p")
		local url = "https://ftp.nluug.nl/pub/vim/runtime/spell/" .. lang .. ".utf-8.spl"
		local cmd = string.format("curl -fLo %s --create-dirs %s", vim.fn.shellescape(spell_file),
			vim.fn.shellescape(url))
		vim.fn.system(cmd)
		vim.notify("Downloaded missing spellfile: " .. lang, vim.log.levels.INFO, { title = "Spell Check" })
	end
end

-- Auto install English and German spellfiles when entering a markdown file
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		ensure_spellfile("en")
		ensure_spellfile("de")
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en", "de" }
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})

vim.keymap.set("n", "<leader>sn", "]s", { desc = "Next Spelling Error" })
vim.keymap.set("n", "<leader>sp", "[s", { desc = "Previous Spelling Error" })

-- Spell Language Picker using Telescope
vim.keymap.set("n", "<leader>ss", function()
	local themes = require("telescope.themes")
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	pickers.new(themes.get_dropdown({
		prompt_title = "Select Spell Language",
	}), {
		finder = finders.new_table {
			results = {
				{ label = "English",          lang = { "en" } },
				{ label = "German",           lang = { "de" } },
				{ label = "English + German", lang = { "en", "de" } },
			},
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry.label,
					ordinal = entry.label,
				}
			end,
		},
		sorter = require("telescope.config").values.generic_sorter(),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				if selection then
					vim.opt_local.spelllang = selection.value.lang
					vim.notify("Set spelllang to: " .. table.concat(selection.value.lang, ", "), vim.log.levels.INFO,
						{ title = "Spell Language" })
				end
			end)
			return true
		end,
	}):find()
end, { desc = "Spell: Select Language" })
