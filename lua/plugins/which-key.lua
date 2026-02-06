return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')
      
      wk.setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        win = {
          border = 'rounded',
          position = 'bottom',
          margin = { 1, 0, 1, 0 },
          padding = { 1, 2, 1, 2 },
          winblend = 0,
          zindex = 1000,
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = 'left',
        },
        show_help = true,
        show_keys = true,
        triggers = 'auto',
        disable = {
          buftypes = {},
          filetypes = { 'TelescopePrompt' },
        },
      })

      -- Registrar grupos de teclas para melhor organização
      wk.add({
        { "<leader>a", group = "AI (Gemini)" },
        { "<leader>aa", desc = "Gemini Actions" },
        { "<leader>ac", desc = "Add to Chat" },
        { "<leader>ai", desc = "Toggle Chat" },
        { "<leader>b", desc = "Toggle File Tree" },
        { "<leader>c", group = "Color" },
        { "<leader>cp", desc = "Color Picker" },
        { "<leader>d", group = "Debug" },
        { "<leader>dr", desc = "DAP REPL" },
        { "<leader>du", desc = "DAP UI" },
        { "<leader>e", desc = "Show Diagnostics" },
        { "<leader>g", group = "Git" },
        { "<leader>gb", desc = "Toggle Blame" },
        { "<leader>gp", desc = "Preview Hunk" },
        { "<leader>j", desc = "Next Terminal Tab" },
        { "<leader>k", desc = "Previous Terminal Tab" },
        { "<leader>lg", desc = "Lazygit" },
        { "<leader>o", desc = "Go to Import" },
        { "<leader>p", desc = "Find Files" },
        { "<leader>q", desc = "Close Window" },
        { "<leader>r", desc = "Replace" },
        { "<leader>t", group = "Window/Terminal" },
        { "<leader>th", desc = "Toggle Inlay Hints" },
      })
    end,
  },
}
