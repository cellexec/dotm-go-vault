-- Autocomplete, Signature Help, etc.
-- https://github.com/Saghen/blink.cmp
return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets', 'hrsh7th/cmp-nvim-lsp' },
	version = '1.*',
	opts = {
		keymap = { preset = 'enter' },
		signature = { enabled = true },
		appearance = { nerd_font_variant = 'mono' },
		completion = {
			documentation = { auto_show = true },
			ghost_text = { enabled = true },
		},
		sources = { default = { 'lsp', 'path', 'snippets' } },
		fuzzy = { implementation = "prefer_rust_with_warning" },
		cmdline = { completion = { ghost_text = { enabled = true } } }
	},
	opts_extend = { "sources.default" }
}
