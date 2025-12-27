return {
  {
    'tpope/vim-fugitive',
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require 'gitsigns'
      gitsigns.setup {
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 200, 
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author> • <author_time:%R> • <summary>',
      }

      vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Gitsigns Preview Hunk' })
      vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame, { desc = 'Toggle Git Blame line' })
    end,
  },
}
