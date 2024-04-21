local builtin = require'telescope.builtin'

require'telescope'.setup{}

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>cm', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gt', builtin.git_status, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
