-- luacheck: globals register_find_mapping register_top_level_mapping

local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")

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
  extensions = {
    media_files = {
      filetypes = { "avi", "jpg", "jpeg", "m4v", "mov", "mp4", "mts", "png", "svg", "webm", "webp", "wmv" },
    },
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
    },
  },
})

register_find_mapping("f", telescope_builtin.find_files, "Files", { mode = "n" })

register_find_mapping("m", telescope.extensions.media_files.media_files, "Media Files", { mode = "n" })

register_find_mapping("u", telescope.extensions.undo.undo, "Undo History", { mode = "n" })

register_find_mapping("w", telescope_builtin.live_grep, "Words", { mode = "n" })

register_find_mapping("gb", telescope_builtin.git_branches, "Git Branches", { mode = "n" })

register_find_mapping("gc", telescope_builtin.git_commits, "Git Commits", { mode = "n" })

register_find_mapping("gl", telescope_builtin.git_status, "Git Local Changes", { mode = "n" })

register_find_mapping("gs", telescope_builtin.git_stash, "Git Stash", { mode = "n" })

register_find_mapping("vb", telescope_builtin.buffers, "Vim Buffers", { mode = "n" })

register_find_mapping("vc", telescope_builtin.buffers, "Vim Commands", { mode = "n" })

register_find_mapping("vh", telescope_builtin.help_tags, "Vim Help", { mode = "n" })
