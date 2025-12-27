
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      -- Inicializa Mason apenas uma vez
      require('mason').setup()

      -- LSP CONFIG attach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnósticos e UI
      vim.diagnostic.config {
        update_in_insert = false,
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local mason_registry = require 'mason-registry'
      local lspconfig = require 'lspconfig'

      local servers = {
        lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } },
        html = {},
        cssls = {},
        tailwindcss = {},
        jsonls = {},
        pyright = {},
        ts_ls = {},
        marksman = {},
        yamlls = {},
        bashls = {},
        dockerls = {},
        eslint = {},
        jdtls = {},
        emmet_language_server = {
          filetypes = { 'css', 'html', 'javascriptreact', 'typescriptreact', 'scss' },
        },
      }

      local optional_servers = {
        gopls = {},
        rust_analyzer = {},
        intelephense = {},
        solargraph = {},
        elixirls = {},
        clangd = {},
        svelte = {},
        volar = {},
        prismals = {},
        sqls = {},
      }

      local function setup_server(server_name)
        local server = servers[server_name] or optional_servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        local config = lspconfig[server_name]
        if not config then
          vim.notify(string.format('LSP "%s" não encontrado no nvim-lspconfig', server_name), vim.log.levels.WARN)
          return
        end
        config.setup(server)
      end

      -- 🔧 Instalação fixa e persistente
      require('mason-tool-installer').setup {
        ensure_installed = {
          -- LSP servers
          'lua-language-server',
          'html-lsp',
          'css-lsp',
          'tailwindcss-language-server',
          'json-lsp',
          'pyright',
          'jdtls',
          'yaml-language-server',
          'bash-language-server',
          'dockerfile-language-server',
          'eslint-lsp',
          'emmet-language-server',
          'marksman',
          -- Formatters / Linters
          'stylua',
          'prettierd',
          'eslint_d',
          'typescript-language-server',
        },
        auto_update = false, -- ⛔ evita re-downloads
        run_on_start = true, -- garante instalações antes de abrir arquivos
        start_delay = 2000,
      }

      require('mason-lspconfig').setup {
        ensure_installed = vim.tbl_keys(servers),
        handlers = {
          function(server_name)
            setup_server(server_name)
          end,
        },
      }

      -- 🔌 Pede para instalar suporte quando abrir um novo tipo de arquivo
      local prompted_filetypes = {}
      local filetype_to_package = {
        go = { package = 'gopls', server = 'gopls' },
        rust = { package = 'rust-analyzer', server = 'rust_analyzer' },
        php = { package = 'intelephense', server = 'intelephense' },
        ruby = { package = 'solargraph', server = 'solargraph' },
        elixir = { package = 'elixir-ls', server = 'elixirls' },
        ['c'] = { package = 'clangd', server = 'clangd' },
        cpp = { package = 'clangd', server = 'clangd' },
        svelte = { package = 'svelte-language-server', server = 'svelte' },
        vue = { package = 'vue-language-server', server = 'volar' },
        prisma = { package = 'prisma-language-server', server = 'prismals' },
        sql = { package = 'sqls', server = 'sqls' },
      }

      local auto_install = vim.api.nvim_create_augroup('MasonAutoPrompt', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = auto_install,
        callback = function(event)
          local ft = event.match
          local mapping = filetype_to_package[ft]
          if not mapping or prompted_filetypes[ft] then
            return
          end

          local ok, pkg = pcall(mason_registry.get_package, mapping.package)
          if not ok then
            return
          end

          if pkg:is_installed() then
            setup_server(mapping.server)
            prompted_filetypes[ft] = true
            return
          end

          prompted_filetypes[ft] = true
          vim.schedule(function()
            local answer = vim.fn.confirm(
              string.format('Instalar suporte LSP para "%s" (%s)?', ft, mapping.package),
              '&Sim\n&Agora não',
              1
            )
            if answer ~= 1 then
              return
            end

            pkg:install()
            pkg:on('install:success', function()
              vim.schedule(function()
                setup_server(mapping.server)
                vim.notify(string.format('%s instalado pelo Mason.', mapping.package), vim.log.levels.INFO)
              end)
            end)
            pkg:on('install:failed', function(_, reason)
              vim.schedule(function()
                prompted_filetypes[ft] = nil
                vim.notify(
                  string.format('Falhou instalar %s: %s', mapping.package, reason or 'motivo desconhecido'),
                  vim.log.levels.ERROR
                )
              end)
            end)
          end)
        end,
      })
    end,
  },
  {
    'chikko80/error-lens.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      auto_adjust = {
        enable = true,
        fallback_bg_color = '#1e1e2e',
        step = 5,
        total = 30,
      },
      prefix = 3,
    },
    config = function(_, opts)
      require('error-lens').setup(opts)
    end,
  },
}
