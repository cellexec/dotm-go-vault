-- Setup LSP configuration (to install use :Mason)
-- https://github.com/neovim/nvim-lspconfig
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
    "williamboman/mason-lspconfig.nvim",
	},
	config = function(event)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require('mason-lspconfig').setup({
      ensure_installed = {
        'lua_ls',
        'ts_ls',
        'html',
        'helm_ls',
        'yamlls',
        'tailwindcss',
        'rust_analyzer',
      },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
          })
        end,
        helm_ls = function()
          require('lspconfig').helm_ls.setup({
            capabilities = capabilities,
            filetypes = { 'helm' },
          })
        end,
        yamlls = function()
          require('lspconfig').yamlls.setup({
            capabilities = capabilities,
            filetypes = { 'yaml.ansible' },
          })
        end,
      },
    })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup('group-lsp-attach', { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)

				if not client then
					print("No LSP client found")
					return
				end

				local map = function(keys, func, desc)
					vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
				end

				-- map('<leader>lr', vim.lsp.buf.rename, '[R]ename')
				map('<leader>lr', function() vim.cmd('Lspsaga rename') end, '[R]ename')
				map('<leader>lR', require('telescope.builtin').lsp_references, '[L]SP [R]eferences')
				map('<leader>li', require('telescope.builtin').lsp_implementations, '[L]SP [I]mplementation')
				map('<leader>la', function() vim.cmd('Lspsaga code_action') end, '[L]SP [A]ction')
				map('<leader>ld', function() vim.cmd('Lspsaga peek_definition') end, '[L]SP [D]efinition')
				map('<leader>lD', function() vim.cmd('Lspsaga peek_definition') end, '[L]SP [D]efinition')
				map('<leader>lD', vim.lsp.buf.definition, '[R]ename')
				map('<leader>lf', function() vim.cmd('Lspsaga finder') end, '[L]SP [F]inder')
				map('<leader>lt', function() vim.cmd('Lspsaga peek_type_definition') end, '[L]SP [T]ype')
				map('<leader>K', function() vim.cmd('Lspsaga hover_doc') end, 'Hover Documentation')
				map('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[L]SP [S]ymbols')
				map('<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
					'[L]SP [Workspace] [S]ymbols')
				map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
						end,
					})
				end

				if client.server_capabilities.documentHighlightProvider and vim.bo[args.buf].filetype ~= 'markdown' then
					local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = function()
							pcall(vim.lsp.buf.document_highlight)
						end,
					})

					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd('LspDetach', {
						group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
						end,
					})
				end
			end,
		})
	end,
}