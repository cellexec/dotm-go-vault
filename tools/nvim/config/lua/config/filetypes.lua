vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = {'*.yaml','*.yml'},
  callback = function()
    if string.match(vim.api.nvim_buf_get_name(0), 'templates') then
      vim.bo.filetype = 'helm'
    end
  end,
})