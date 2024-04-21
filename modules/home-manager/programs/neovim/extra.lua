local function disable_arrow_keys(mode)
  vim.api.nvim_set_keymap(mode, '<Up>', '<NOP>', { noremap = true })
  vim.api.nvim_set_keymap(mode, '<Down>', '<NOP>', { noremap = true })
  vim.api.nvim_set_keymap(mode, '<Right>', '<NOP>', { noremap = true })
  vim.api.nvim_set_keymap(mode, '<Left>', '<NOP>', { noremap = true })
end

local document_width = 72
local modes = { 'c', 'i', 'l', 'n', 'o', 's', 't', 'v', 'x' }

for _, mode in ipairs(modes) do
  disable_arrow_keys(mode) -- 😈
end

vim.g.dhall_format = 1
vim.g.mapleader = ' '

vim.o.laststatus = 3
vim.o.showmode = false

vim.o.clipboard = 'unnamedplus'
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.mouse = 'a'

vim.o.number = true
vim.o.numberwidth = 2
vim.o.ruler = false


vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeoutlen = 400
vim.o.undofile = true
vim.o.updatetime = 250

vim.opt.background = 'dark'
vim.opt.colorcolumn = tostring(document_width + 1)
vim.opt.fillchars = { eob = ' ' }
vim.opt.guicursor = ''
vim.opt.relativenumber = true
vim.opt.shortmess:append 'sI'
vim.opt.whichwrap:append '<>[]hl'

vim.wo.relativenumber = true

vim.keymap.set('n', '<leader>nh', '<cmd>nohlsearch<CR>', { desc = 'Remove search highlight' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Switch Window left' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Switch Window right' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Switch Window down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Switch Window up' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Lsp prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Lsp next diagnostic' })

vim.filetype.add({
  extension = {
    purs = "purescript",
  },
})
