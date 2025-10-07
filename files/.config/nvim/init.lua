
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'utf-8,sjis'

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.opt.clipboard:append({"unnamedplus"})

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true


vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.wrap = false

vim.opt.mouse = 'a'
vim.opt.scrolloff = 8

vim.opt.signcolumn = 'yes'

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- shortcuts
vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>', { silent = true })

