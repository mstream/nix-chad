local function setup_nerdtree(context) -- luacheck: ignore
	context.register_directory_tree_mapping("t", "<cmd>NERDTreeToggle<CR>", "Toggle", { mode = "n" })
	context.register_directory_tree_mapping("f", "<cmd>NERDTreeFocus<CR>", "Focus", { mode = "n" })
end
