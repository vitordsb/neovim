return {
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_enable_italic_comment = 1
      vim.g.everforest_better_performance = 1

      local function apply_for_time()
        local hour = tonumber(os.date '%H')
        local is_daytime = hour >= 7 and hour < 18
        local background = is_daytime and 'light' or 'dark'
        local contrast = is_daytime and 'soft' or 'hard'

        -- Only re-apply when something changes to avoid flicker
        if vim.o.background ~= background or vim.g.everforest_background ~= contrast or vim.g.colors_name ~= 'everforest' then
          vim.o.background = background
          vim.g.everforest_background = contrast
          vim.cmd.colorscheme 'everforest'
        end
      end

      apply_for_time()

      local day_night = vim.api.nvim_create_augroup('EverforestDayNight', { clear = true })
      vim.api.nvim_create_autocmd({ 'VimEnter', 'FocusGained' }, {
        group = day_night,
        callback = apply_for_time,
        desc = 'Ajusta tema claro/escuro conforme o horário',
      })

      local timer = vim.loop.new_timer()
      timer:start(0, 900000, vim.schedule_wrap(apply_for_time)) -- checa a cada 15 min
      vim.api.nvim_create_autocmd('VimLeavePre', {
        group = day_night,
        callback = function()
          if timer:is_active() then
            timer:stop()
          end
          timer:close()
        end,
      })
    end,
  },
}
