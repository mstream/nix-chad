-- luacheck: globals custom_key_mappings

local function setup_which_key_nvim(context) -- luacheck: ignore
    local which_key = require("which-key")

    which_key.setup({})

    local function log_mapping(spec)
        local name = spec.name
        for k, v in ipairs(spec) do
            if k ~= "name" then
                context.keymap_logger.debug(
                    "registring "
                        .. name
                        .. " mapping for '"
                        .. v
                        .. "' key"
                )
            end
        end
    end

    local function register_top_level_mapping(lhs, rhs, desc, opts)
        local spec = { rhs, desc }
        context.keymap_logger.debug(
            "registring top level  mapping for '" .. lhs .. "'"
        )
        which_key.register({ [lhs] = spec }, opts)
    end

    local function register_debug_mapping(key, rhs, what, opts)
        local spec =
            { name = "debug", [key] = { rhs, "Debug " .. what } }
        log_mapping(spec)
        which_key.register({ ["<leader>d"] = spec }, opts)
    end

    local function register_directory_tree_mapping(key, rhs, what, opts)
        local spec = {
            name = "tree",
            [key] = { rhs, "Directory Tree " .. what },
        }
        log_mapping(spec)
        which_key.register({ ["<leader>t"] = spec }, opts)
    end

    local function register_find_mapping(key, rhs, what, opts)
        local spec = { name = "find", [key] = { rhs, "Find " .. what } }
        log_mapping(spec)
        which_key.register({ ["<leader>f"] = spec }, opts)
    end

    local function register_go_to_mapping(key, rhs, where, opts)
        local spec =
            { name = "go to", [key] = { rhs, "Go to " .. where } }
        log_mapping(spec)
        which_key.register({ ["<leader>g"] = spec }, opts)
    end

    local function register_refactor_mapping(key, rhs, what, opts)
        local spec =
            { name = "refactor", [key] = { rhs, "Refactor " .. what } }
        log_mapping(spec)
        which_key.register({ ["<leader>r"] = spec }, opts)
    end

    context.vim.api.nvim_create_autocmd("VimEnter", {
        group = context.vim.api.nvim_create_augroup(
            "CoreKeyMapping",
            {}
        ),
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
                ["z"] = {
                    name = "fold",
                },
                ["<C-a>"] = { desc = "Incrment number under cursor" },
                ["<C-d>"] = { desc = "Move window down" },
                ["<C-u>"] = { desc = "Move window up" },
                ["<C-x>"] = { desc = "Decremen number under cursor" },
            })

            register_top_level_mapping(
                custom_key_mappings.top_level.show_key_mappings.combination,
                "<cmd>WhichKey<CR>",
                custom_key_mappings.top_level.show_key_mappings.description,
                { mode = "n" }
            )

            register_top_level_mapping(
                custom_key_mappings.top_level.move_to_left_window.combination,
                "<C-w>h",
                custom_key_mappings.top_level.move_to_left_window.description,
                { mode = "n" }
            )

            register_top_level_mapping(
                custom_key_mappings.top_level.move_to_right_window.combination,
                "<C-w>l",
                custom_key_mappings.top_level.move_to_right_window.description,
                { mode = "n" }
            )

            register_top_level_mapping(
                custom_key_mappings.top_level.move_to_top_window.combination,
                "<C-w>k",
                custom_key_mappings.top_level.move_to_top_window.description,
                { mode = "n" }
            )

            register_top_level_mapping(
                custom_key_mappings.top_level.move_to_bottom_window.combination,
                "<C-w>j",
                custom_key_mappings.top_level.move_to_bottom_window.description,
                { mode = "n" }
            )

            register_go_to_mapping(
                custom_key_mappings.go_to.previous_problem.combination,
                context.vim.diagnostic.goto_prev,
                custom_key_mappings.go_to.previous_problem.description,
                { mode = "n" }
            )

            register_go_to_mapping(
                custom_key_mappings.go_to.next_problem.combination,
                context.vim.diagnostic.goto_next,
                custom_key_mappings.go_to.next_problem.description,
                { mode = "n" }
            )

            register_go_to_mapping(
                "u",
                "<C-o>",
                "Previous Cursor Position",
                { mode = "n" }
            )
        end,
    })

    return {
        register_debug_mapping = register_debug_mapping,
        register_directory_tree_mapping = register_directory_tree_mapping,
        register_find_mapping = register_find_mapping,
        register_go_to_mapping = register_go_to_mapping,
        register_refactor_mapping = register_refactor_mapping,
        register_top_level_mapping = register_top_level_mapping,
    }
end
