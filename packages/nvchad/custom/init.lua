vim.g.dhall_format = 1
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local document_width = 72

autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/s+$//e",
})

local remove_spaces_group = augroup("RemoveSpaces", { clear = true })

autocmd("BufWritePre", {
	pattern = "*",
	command = ":%s/s+$//e",
	group = remove_spaces_group,
})

local highlight_group = augroup("YankHighlight", { clear = true })

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

local function disable_arrow_keys(mode)
	vim.api.nvim_set_keymap(mode, "<Up>", "<NOP>", { noremap = true })
	vim.api.nvim_set_keymap(mode, "<Down>", "<NOP>", { noremap = true })
	vim.api.nvim_set_keymap(mode, "<Right>", "<NOP>", { noremap = true })
	vim.api.nvim_set_keymap(mode, "<Left>", "<NOP>", { noremap = true })
end

for _, mode in ipairs({ "c", "i", "l", "n", "o", "s", "t", "v", "x" }) do
	disable_arrow_keys(mode)
end

vim.wo.relativenumber = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = tostring(document_width + 1)
vim.opt.guicursor = ""

vim.filetype.add({
	extension = {
		purs = "purescript",
	},
})
