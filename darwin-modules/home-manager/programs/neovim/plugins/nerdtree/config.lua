-- luacheck: globals custom_key_mappings

local function setup_nerdtree(context) -- luacheck: ignore
    context.register_directory_tree_mapping(
        custom_key_mappings.directory_tree.toggle.combination,
        "<cmd>NERDTreeToggle<CR>",
        custom_key_mappings.directory_tree.toggle.description,
        { mode = "n" }
    )
    context.register_directory_tree_mapping(
        custom_key_mappings.directory_tree.focus.combination,
        "<cmd>NERDTreeFocus<CR>",
        custom_key_mappings.directory_tree.focus.description,
        { mode = "n" }
    )
end
