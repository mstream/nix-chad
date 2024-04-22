local telescope = require 'telescope'
local telescope_builtin = require 'telescope.builtin'

telescope.setup {}

registerFindMapping(
  'b',
  telescope_builtin.buffers,
  'Buffers',
  { mode = 'n' }
)

registerFindMapping(
  'f',
  telescope_builtin.find_files,
  'Files',
  { mode = 'n' }
)

registerFindMapping(
  'h',
  telescope_builtin.help_tags,
  'Help',
  { mode = 'n' }
)

registerFindMapping(
  'w',
  telescope_builtin.live_grep,
  'Words',
  { mode = 'n' }
)

registerFindMapping(
  'gcm',
  telescope_builtin.git_commits,
  'Git Commits',
  { mode = 'n' }
)

registerFindMapping(
  'glc',
  telescope_builtin.git_status,
  'Git Local Changes',
  { mode = 'n' }
)
