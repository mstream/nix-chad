-- luacheck: globals keymap_logger vim
-- luacheck: no unused

local which_key = require("which-key")

which_key.setup({})

local function log_mapping(spec)
	local name = spec.name
	for k, v in ipairs(spec) do
		if k ~= "name" then
			keymap_logger.debug("registring " .. name .. " mapping for '" .. v .. "' key")
		end
	end
end

local function register_top_level_mapping(lhs, rhs, desc, opts)
	local spec = { rhs, desc }
	keymap_logger.debug("registring top level  mapping for '" .. lhs .. "'")
	which_key.register({ [lhs] = spec }, opts)
end

local function register_debug_mapping(key, rhs, what, opts)
	local spec = { name = "debug", [key] = { rhs, "Debug " .. what } }
	log_mapping(spec)
	which_key.register({ ["<leader>d"] = spec }, opts)
end

local function register_directory_tree_mapping(key, rhs, what, opts)
	local spec = { name = "tree", [key] = { rhs, "Directory Tree " .. what } }
	log_mapping(spec)
	which_key.register({ ["<leader>t"] = spec }, opts)
end

local function register_find_mapping(key, rhs, what, opts)
	local spec = { name = "find", [key] = { rhs, "Find " .. what } }
	log_mapping(spec)
	which_key.register({ ["<leader>f"] = spec }, opts)
end

local function register_go_to_mapping(key, rhs, where, opts)
	local spec = { name = "go to", [key] = { rhs, "Go to " .. where } }
	log_mapping(spec)
	which_key.register({ ["<leader>g"] = spec }, opts)
end

local function register_refactor_mapping(key, rhs, what, opts)
	local spec = { name = "refactor", [key] = { rhs, "Refactor " .. what } }
	log_mapping(spec)
	which_key.register({ ["<leader>r"] = spec }, opts)
end

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("CoreKeyMapping", {}),
	callback = function()
		which_key.register({
			["."] = { desc = "Repeat last command" },
			["%"] = { desc = "Go to nearest matching parenthesis" },
			["/"] = { desc = "Search forwards" },
			["?"] = { desc = "Search backwards" },
			["#"] = { desc = "Search previous word under cursor" },
			["*"] = { desc = "Search next word under cursor" },
			["gf"] = { desc = "Go to file under cursor" },
			["n"] = { desc = "Search next matching pattern" },
			["N"] = { desc = "Search previous matching pattern" },
			["z"] = { name = "fold" },
			["<C-a>"] = { desc = "Incrment number under cursor" },
			["<C-d>"] = { desc = "Move window down" },
			["<C-u>"] = { desc = "Move window up" },
			["<C-x>"] = { desc = "Decremen number under cursor" },
		}, { mode = "n" })

		register_top_level_mapping("\\", "<cmd>WhichKey<CR>", "Show Key Mappings", { mode = "n" })

		register_top_level_mapping(
			"<C-u>",
			"<C-p>",
			"Search Command Backwards",
			{ mode = "c", noremap = true, silent = false }
		)

		register_top_level_mapping(
			"<C-d>",
			"<C-n>",
			"Search Command Forwards",
			{ mode = "c", noremap = true, silent = false }
		)

		register_top_level_mapping("<C-h>", "<C-w>h", "Move to Window on the Left", { mode = "n" })

		register_top_level_mapping("<C-l>", "<C-w>l", "Move to Window on the Right", { mode = "n" })

		register_top_level_mapping("<C-k>", "<C-w>k", "Move to Window on the Top", { mode = "n" })

		register_top_level_mapping("<C-j>", "<C-w>j", "Move to Window on the Bottom", { mode = "n" })

		register_go_to_mapping("[", vim.diagnostic.goto_prev, "Previous Problem", { mode = "n" })

		register_go_to_mapping("]", vim.diagnostic.goto_next, "Next Problem", { mode = "n" })
	end,
})
