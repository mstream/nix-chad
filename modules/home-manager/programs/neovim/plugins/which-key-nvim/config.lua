local which_key = require 'which-key'

which_key.setup {}

local function registerTopLevelMapping(lhs, rhs, desc, opts)
  which_key.register({
      [lhs] = { rhs, desc, }
    },
    opts
  )
end

local function registerDebugMapping(key, rhs, what, opts)
  which_key.register({
      ['<leader>d'] = { name = 'debug', [key] = { rhs, "Debug " .. what, } }
    },
    opts
  )
end

local function registerFindMapping(key, rhs, what, opts)
  which_key.register({
      ['<leader>f'] = { name = 'find', [key] = { rhs, "Find " .. what, } }
    },
    opts
  )
end

local function registerGoToMapping(key, rhs, where, opts)
  which_key.register({
      ['<leader>g'] = { name = 'go to', [key] = { rhs, "Go to " .. where, } }
    },
    opts
  )
end

local function registerRefactorMapping(key, rhs, what, opts)
  which_key.register({
      ['<leader>r'] = { name = 'refactor', [key] = { rhs, "Refactor " .. what, } }
    },
    opts
  )
end

which_key.register({
  ['.'] = { desc = "Repeat last command" },
  ['%'] = { desc = "Go to nearest matching parenthesis" },
  ['/'] = { desc = "Search forwards" },
  ['?'] = { desc = "Search backwards" },
  ['#'] = { desc = "Search previous word under cursor" },
  ['*'] = { desc = "Search next word under cursor" },
  ['gf'] = { desc = "Go to file under cursor" },
  ['K'] = { desc = "Display information about symbol under cursor" },
  ['n'] = { desc = "Search next matching pattern" },
  ['N'] = { desc = "Search previous matching pattern" },
  ['z'] = {
    name = "fold",
  },
  ['<C-A>'] = { desc = "Incrment number under cursor" },
  ['<C-X>'] = { desc = "Decremen number under cursor" },
})

registerTopLevelMapping(
  '\\',
  '<cmd>WhichKey<CR>',
  'Show Key Mappings',
  { mode = 'n', }
)

registerTopLevelMapping(
  '<C-h>',
  '<C-w>h',
  'Move to Window on the Left',
  { mode = 'n', }
)

registerTopLevelMapping(
  '<C-l>',
  '<C-w>l',
  'Move to Window on the Right',
  { mode = 'n', }
)

registerTopLevelMapping(
  '<C-k>',
  '<C-w>k',
  'Move to Window on the Top',
  { mode = 'n', }
)

registerTopLevelMapping(
  '<C-j>',
  '<C-w>j',
  'Move to Window on the Bottom',
  { mode = 'n', }
)

registerGoToMapping(
  '[',
  vim.diagnostic.goto_prev,
  'Previous Problem',
  { mode = 'n', }
)

registerGoToMapping(
  ']',
  vim.diagnostic.goto_next,
  'Next Problem',
  { mode = 'n', }
)
