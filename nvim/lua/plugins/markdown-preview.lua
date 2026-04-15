return {
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_auto_close = 0
    end,
  },
}
