-- LSP Saga
-- https://github.com/nvimdev/lspsaga.nvim
return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For icons
  },
  config = function()
    require("lspsaga").setup({
      -- Your configuration options here
      -- For example, to enable lightbulb:
      lightbulb = {
        enable = false,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
      },
      -- You can add more configurations as needed
      -- For example, to customize hover:
      hover = {
        max_width = 80,
      },
      outline = {
        keys = {
          toggle_or_jump = '<space>',
          jump = '<CR>',
          quit = '<Esc>',
        },
        close_after_jump = true,
      },
    })

    -- Close floating windows with Esc
    vim.keymap.set('n', '<Esc>', function()
      if vim.api.nvim_win_get_config(0).relative ~= '' then
        vim.api.nvim_win_close(0, true)
      end
    end, { silent = true, desc = 'Close floating window' })

    vim.keymap.set('n', '<leader>lr', '<cmd>Lspsaga rename<CR>', { silent = true, desc = 'Lspsaga rename' })
    vim.keymap.set('n', '<leader>lo', '<cmd>Lspsaga outline<CR>', { silent = true, desc = 'Lspsaga outline' })
  end,
}
