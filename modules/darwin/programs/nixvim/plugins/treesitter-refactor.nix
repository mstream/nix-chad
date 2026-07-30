{
  # Disabled: nvim-treesitter-refactor depends on nvim-treesitter-legacy,
  # which conflicts with plugins.treesitter (nvim-treesitter main).
  # Re-enable once upstream migrates off the legacy configs API.
  # See nixpkgs 26.05 notes and neovim packaging docs for the dual-package guard.
  programs.nixvim.plugins.treesitter-refactor = {
    enable = false;
  };
}
