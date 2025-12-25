
vim.opt.mouse = 'a' -- allow mouse usage in nvim
vim.opt.clipboard = 'unnamedplus' -- use system clipboard

-- search 
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true -- incrementally search via entering
vim.opt.hlsearch = false

-- tab
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- ui config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.showmatch = true

-- edit
vim.opt.undofile = true
vim.opt.encoding = 'utf-8'