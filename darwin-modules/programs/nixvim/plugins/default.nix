{
  imports = [
    ./arrow.nix
    ./barbar.nix
    # This is not an nvim-cmp add-on. It is a replacement.
    #./blink-cmp.nix
    ./cmp/default.nix
    # These are auto-enabled by the cmp plugin.
    #./cmp-calc.nix
    #./cmp-cmdline.nix
    #./cmp-cmdline-history.nix
    #./cmp-conventionalcommits.nix
    #./cmp-dap.nix
    #./cmp-dictionary.nix
    #./cmp-digraphs.nix
    #./cmp-emoji.nix
    #./cmp-fuzzy-buffer.nix
    #./cmp-fuzzy-path.nix
    #./cmp-git.nix
    #./cmp-greek.nix
    #./cmp-latex-symbols.nix
    #./cmp-luasnip.nix
    #./cmp-npm.nix
    #./cmp-nvim-lsp-document-symbol.nix
    #./cmp-nvim-lsp-signature-help.nix
    #./cmp-treesitter.nix
    ./conform-nvim.nix
    ./flash.nix
    ./friendly-snippets.nix
    ./lint.nix
    ./lsp.nix
    ./lspkind.nix
    ./lualine.nix
    ./luasnip.nix
    ./telescope.nix
    ./treesitter.nix
    ./treesitter-context.nix
    ./treesitter-refactor.nix
    ./treesitter-textobjects
    ./web-devicons.nix
  ];
}
