return {
  {
    'akinsho/toggleterm.nvim',
    version = 'v2.*',
    config = function()
      require('toggleterm').setup {
        size = 15,
        open_mapping = [[<c-j>]], -- Ctrl+j abre/fecha terminal
        direction = 'horizontal',
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        persist_size = true,
        persist_mode = true,
      }

      -- Keymaps dentro do terminal (modo terminal)
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      -- Lazygit integration
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      -- Sistema de terminais numerados (muito mais simples e confiável)
      -- Alt+1: Terminal 1
      vim.keymap.set("n", "<A-1>", "<Cmd>1ToggleTerm<CR>", {noremap = true, silent = true, desc = "Toggle Terminal 1"})
      vim.keymap.set("t", "<A-1>", "<Cmd>1ToggleTerm<CR>", {noremap = true, silent = true, desc = "Toggle Terminal 1"})
      
      -- Alt+2: Terminal 2
      vim.keymap.set("n", "<A-2>", "<Cmd>2ToggleTerm<CR>", {noremap = true, silent = true, desc = "Toggle Terminal 2"})
      vim.keymap.set("t", "<A-2>", "<Cmd>2ToggleTerm<CR>", {noremap = true, silent = true, desc = "Toggle Terminal 2"})
      
      -- Alt+3: Terminal 3
      vim.keymap.set("n", "<A-3>", "<Cmd>3ToggleTerm<CR>", {noremap = true, silent = true, desc = "Toggle Terminal 3"})
      vim.keymap.set("t", "<A-3>", "<Cmd>3ToggleTerm<CR>", {noremap = true, silent = true, desc = "Toggle Terminal 3"})

      -- Navegação entre terminais (funciona em qualquer modo)
      vim.keymap.set({"n", "t"}, "<A-j>", "<Cmd>ToggleTermToggleAll<CR><Cmd>ToggleTermGoNext<CR>", {noremap = true, silent = true, desc = "Next terminal"})
      vim.keymap.set({"n", "t"}, "<A-k>", "<Cmd>ToggleTermToggleAll<CR><Cmd>ToggleTermGoPrevious<CR>", {noremap = true, silent = true, desc = "Previous terminal"})
    end,
  },
}
