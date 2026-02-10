return {
	'epwalsh/obsidian.nvim',
	version = '*',
	lazy = true,
	ft = 'markdown',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	opts = function(_, _)
		-- Try to load ./local/obsidian-vaults.lua (relative to this plugin file)
		local ok, local_workspaces = pcall(require, 'plugins.local.obsidian-vaults')

		return {
			workspaces = ok and local_workspaces,
			ui = { enable = false },
		}
	end,
	keys = {
		{ '<leader>ob',  ':ObsidianBacklinks<CR>',   desc = '[B]acklinks' },
		{ '<leader>oc',  ':ObsidianTOC<CR>',         desc = '[C]urrent TOC' },
		{ '<leader>ods', ':ObsidianDailies<CR>',     desc = '[D]aily [S]earch' },
		{ '<leader>odn', ':ObsidianToday<CR>',       desc = '[D]aily [N]ew' },
		{ '<leader>oe',  ':ObsidianExtractNote<CR>', mode = { 'v' },                       desc = '[E]xtract Note' },
		{ '<leader>ol',  ':ObsidianLinks<CR>',       desc = '[L]inks' },
		{ '<leader>onf', ':ObsidianNew<CR>',         desc = '[N]ew [F]ile' },
		{ '<leader>onl', ':ObsidianLinkNew<CR>',     desc = '[N]ew [L]ink' },
		{ '<leader>op',  ':ObsidianPasteImg<CR>',    desc = '[P]aste Image from clipboard' },
		{ '<leader>ot',  ':ObsidianTags<CR>',        desc = '[T]ags' },
		{ '<leader>oq',  ':ObsidianQuickSwitch<CR>', desc = '[Q]uickswitch' },
		{ '<leader>ow',  ':ObsidianWorkspace<CR>',   desc = '[W]orkspace' },
	},
}
