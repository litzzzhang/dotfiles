return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.clangd = opts.servers.clangd or {}

      local clangd = opts.servers.clangd
      clangd.capabilities = clangd.capabilities or {}
      clangd.capabilities.offsetEncoding = nil
      clangd.cmd = vim.deepcopy(clangd.cmd or { "clangd" })
      for index, argument in ipairs(clangd.cmd) do
        if argument == "--function-arg-placeholders" then
          clangd.cmd[index] = "--function-arg-placeholders=1"
        end
      end
      clangd.before_init = function(params)
        if params.capabilities then
          params.capabilities.offsetEncoding = nil
        end
      end
    end,
  },
}
