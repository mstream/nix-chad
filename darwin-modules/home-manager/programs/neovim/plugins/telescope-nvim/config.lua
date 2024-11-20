-- luacheck: globals custom_key_mappings

local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")

local function setup_telescope_nvim(context) -- luacheck: ignore
    local telescope_mappins = {
        ["<C-d>"] = telescope_actions.move_selection_next,
        ["<C-u>"] = telescope_actions.move_selection_previous,
        ["<C-A-d>"] = telescope_actions.preview_scrolling_down,
        ["<C-A-u>"] = telescope_actions.preview_scrolling_up,
    }

    telescope.setup({
        defaults = {
            mappings = {
                i = telescope_mappins,
                n = telescope_mappins,
            },
        },
    })

    context.register_find_mapping(
        custom_key_mappings.find.files.combination,
        telescope_builtin.find_files,
        custom_key_mappings.find.files.description,
        { mode = "n" }
    )

    context.register_find_mapping(
        custom_key_mappings.find.git_branches.combination,
        telescope_builtin.git_branches,
        custom_key_mappings.find.git_branches.description,
        { mode = "n" }
    )

    context.register_find_mapping(
        custom_key_mappings.find.words.combination,
        telescope_builtin.live_grep,
        custom_key_mappings.find.words.description,
        { mode = "n" }
    )

    context.register_find_mapping(
        custom_key_mappings.find.git_commits.combination,
        telescope_builtin.git_commits,
        custom_key_mappings.find.git_commits.description,
        { mode = "n" }
    )

    context.register_find_mapping(
        custom_key_mappings.find.git_local_changes.combination,
        telescope_builtin.git_status,
        custom_key_mappings.find.git_local_changes.description,
        { mode = "n" }
    )

    context.register_find_mapping(
        custom_key_mappings.find.git_stash.combination,
        telescope_builtin.git_stash,
        custom_key_mappings.find.git_stash.description,
        { mode = "n" }
    )

    context.register_find_mapping(
        custom_key_mappings.find.vim_buffers.combination,
        telescope_builtin.buffers,
        custom_key_mappings.find.vim_buffers.description,
        { mode = "n" }
    )

    context.register_find_mapping(
        custom_key_mappings.find.vim_commands.combination,
        telescope_builtin.commands,
        custom_key_mappings.find.vim_commands.description,
        { mode = "n" }
    )

    context.register_find_mapping(
        custom_key_mappings.find.vim_help.combination,
        telescope_builtin.help_tags,
        custom_key_mappings.find.vim_help.description,
        { mode = "n" }
    )
end
