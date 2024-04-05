{pkgs, ...}:
[
  (import ./vim-airline { inherit pkgs; })
  (import ./vim-airline-themes { inherit pkgs; })
  (import ./gruvbox-nvim { inherit pkgs; })
  (import ./plenary-nvim { inherit pkgs; })
  (import ./telescope-nvim { inherit pkgs; })
  (import ./telescope-fzf-native-nvim { inherit pkgs; })
  (import ./efmls-configs-nvim { inherit pkgs; })
  (import ./cmp-nvim-lsp { inherit pkgs; })
  (import ./lsp-format-nvim { inherit pkgs; })
  (import ./nvim-lspconfig { inherit pkgs; })
  (import ./luasnip { inherit pkgs; })
  (import ./cmp-nvim-lsp-document-symbol { inherit pkgs; })
  (import ./cmp-omni { inherit pkgs; })
  (import ./cmp-path { inherit pkgs; })
  (import ./nvim-cmp { inherit pkgs; })
  (import ./nvim-treesitter { inherit pkgs; })
  (import ./vim-devicons { inherit pkgs; })
  (import ./nvim-web-devicons { inherit pkgs; })
  (import ./trouble-nvim { inherit pkgs; })
  (import ./nerdtree { inherit pkgs; })
  (import ./vim-nerdtree-syntax-highlight { inherit pkgs; })
  (import ./nerdtree-git-plugin { inherit pkgs; })
] 
