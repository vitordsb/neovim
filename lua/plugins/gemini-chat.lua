return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "gemini",
          },
          inline = {
            adapter = "gemini",
          },
        },
        adapters = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "GEMINI_API_KEY",
              },
              schema = {
                model = {
                  default = "gemini-2.0-flash-exp",
                },
              },
            })
          end,
        },
        display = {
          chat = {
            window = {
              layout = "vertical", -- Chat no lado direito
              width = 0.4,         -- 40% da largura da tela
              height = 0.9,        -- 90% da altura
              relative = "editor",
              border = "rounded",
              title = "Gemini Chat",
              title_pos = "center",
            },
            intro_message = "👋 Olá! Sou o Gemini. Como posso ajudar você hoje?",
          },
          inline = {
            diff = {
              enabled = true,
              close_chat_at = 240,
            },
          },
        },
      })

      -- Keybindings para o chat
      vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { 
        noremap = true, 
        silent = true, 
        desc = "Toggle Gemini Chat" 
      })
      
      vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanionChat Toggle<cr>", { 
        noremap = true, 
        silent = true, 
        desc = "Toggle Gemini Chat with selection" 
      })
      
      vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { 
        noremap = true, 
        silent = true, 
        desc = "Gemini Actions" 
      })
      
      vim.keymap.set("v", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { 
        noremap = true, 
        silent = true, 
        desc = "Gemini Actions on selection" 
      })

      -- Atalho rápido para adicionar código selecionado ao chat
      vim.keymap.set("v", "<leader>ac", "<cmd>CodeCompanionChat Add<cr>", { 
        noremap = true, 
        silent = true, 
        desc = "Add selection to Gemini Chat" 
      })
    end,
  },
}
