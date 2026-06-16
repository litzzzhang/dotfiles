-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- ~/.config/nvim/lua/config/options.lua

vim.opt.clipboard = "unnamedplus"

-- 不要全局强制 osc52
vim.g.clipboard = nil

-- Neovide：走 GUI / 系统剪贴板，不使用 OSC52
if vim.g.neovide then
  vim.g.clipboard = nil
else
  -- tmux：使用 tmux buffer，不走 OSC52 paste，因此不会卡在等待 OSC52 response
  if vim.env.TMUX and vim.fn.executable("tmux") == 1 then
    local function tmux_has_load_buffer_w()
      local out = vim.fn.system({ "tmux", "-V" })
      local major, minor = out:match("tmux (%d+)%.(%d+)")
      major, minor = tonumber(major), tonumber(minor)
      return major and (major > 3 or (major == 3 and minor >= 2))
    end

    local copy_cmd = tmux_has_load_buffer_w() and { "tmux", "load-buffer", "-w", "-" } or { "tmux", "load-buffer", "-" }

    vim.g.clipboard = {
      name = "tmux",
      copy = {
        ["+"] = copy_cmd,
        ["*"] = copy_cmd,
      },
      paste = {
        ["+"] = { "tmux", "save-buffer", "-" },
        ["*"] = { "tmux", "save-buffer", "-" },
      },
      cache_enabled = 1,
    }

  -- SSH / remote / container：只用 OSC52 复制，不用 OSC52 粘贴
  elseif vim.env.SSH_TTY then
    local ok, osc52 = pcall(require, "vim.ui.clipboard.osc52")
    if ok then
      local function paste()
        return {
          vim.fn.split(vim.fn.getreg(""), "\n"),
          vim.fn.getregtype(""),
        }
      end

      vim.g.clipboard = {
        name = "OSC52-copy-only",
        copy = {
          ["+"] = osc52.copy("+"),
          ["*"] = osc52.copy("*"),
        },
        paste = {
          ["+"] = paste,
          ["*"] = paste,
        },
      }
    end
  end
end
