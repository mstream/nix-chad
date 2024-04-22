-- luacheck: globals vim

local function disable_mapping(mode, lhs)
	vim.api.nvim_set_keymap(mode, lhs, "<NOP>", { noremap = true })
end

local function disable_arrow_keys(mode)
	disable_mapping(mode, "<Up>")
	disable_mapping(mode, "<Down>")
	disable_mapping(mode, "<Right>")
	disable_mapping(mode, "<Left>")
end

local document_width = 72
local modes = { "c", "i", "l", "n", "o", "s", "t", "v", "x" }

for _, mode in ipairs(modes) do
	disable_arrow_keys(mode)
end

vim.g.dhall_format = 1
vim.g.mapleader = " "

vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.mouse = "a"
vim.o.number = true
vim.o.numberwidth = 2
vim.o.ruler = false
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250

vim.opt.background = "dark"
vim.opt.colorcolumn = tostring(document_width + 1)
vim.opt.fillchars = { eob = " " }
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldnestmax = 4
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.shortmess:append("sI")
vim.opt.whichwrap:append("<>[]hl")

vim.wo.relativenumber = true

vim.filetype.add({
	extension = {
		purs = "purescript",
	},
})
