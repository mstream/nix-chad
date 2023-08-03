{ pkgs, ... }: {
  enable = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  extraConfig =
    ''
      	lua require('init')
    '';
  plugins = with pkgs.vimPlugins; [
    cmp-buffer
    cmp-calc
    cmp-emoji
    cmp-nvim-lsp
    cmp-nvim-lsp-document-symbol
    cmp-omni
    cmp-path
    cmp-spell
    cmp-vsnip
    dhall-vim
    gruvbox
    lsp_signature-nvim
    lsp-status-nvim
    nvim-cmp
    nvim-lspconfig
    nvim-treesitter.withAllGrammars
    nvim-web-devicons
    plenary-nvim
    purescript-vim
    telescope-nvim
    vim-airline
    vim-airline-themes
    vim-vsnip
  ];
}
