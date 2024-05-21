local function setup_gruvbox_nvim(context) -- luacheck: ignore
	require("gruvbox").setup({
		contrast = "hard",
		terminal_colors = true,
		transparent_mode = false,
	})

	context.vim.cmd("colorscheme gruvbox")
end
