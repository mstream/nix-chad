local function setup_bufferline_nvim(context) -- luacheck: ignore
	context.vim.opt.termguicolors = true
	require("bufferline").setup({})
end
