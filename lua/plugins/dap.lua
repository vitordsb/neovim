return {
  -- Debug Adapter Protocol (DAP)
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- UI for DAP
      {
        'rcarriga/nvim-dap-ui',
        dependencies = {'nvim-neotest/nvim-nio'},
        config = function()
          local dapui = require('dapui')
          dapui.setup()

          -- Add listeners for DAP events to automatically open and close the UI
          local dap = require('dap')
          dap.listeners.after.event_initialized['dapui_config'] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated['dapui_config'] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited['dapui_config'] = function()
            dapui.close()
          end
        end
      },
      -- Virtual text for debugging
      { 'theHamsta/nvim-dap-virtual-text' },

      -- Example for Go language.
      -- For other languages, you may need to install other plugins.
      -- For example, for python: require('dap-python').setup('python')
      { 'leoluz/nvim-dap-go' }
    },
    config = function()
      -- Safely setup dap-go if available
      local has_dap_go, dap_go = pcall(require, 'dap-go')
      if has_dap_go then
        dap_go.setup()
      end

      -- Safely setup dap-virtual-text if available
      local has_virtual_text, virtual_text = pcall(require, 'nvim-dap-virtual-text')
      if has_virtual_text then
        virtual_text.setup()
      end
    end,
  },
}
