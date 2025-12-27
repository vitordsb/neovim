local function rename_tmux_window()
  if vim.env.TMUX == nil then
    return
  end

  local name = vim.fn.expand("%:t")
  if name == "" then
    name = "nvim"
  end

  vim.fn.system({ "tmux", "rename-window", name })
end

vim.api.nvim_create_autocmd(
  { "BufEnter", "BufWinEnter" },
  {
    callback = rename_tmux_window,
  }
)
