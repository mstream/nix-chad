{ pkgs, ... }:
let
  textLintPackage = pkgs.textlint;
in
{
  programs.nixvim.plugins.none-ls = {
    enable = false;
    enableLspFormat = true;
    settings = {
      debounce = 500;
      debug = false;
      default_timeout = 5000;
      log_level = "warn";
      update_in_insert = false;
    };
    sources = {
      code_actions = {
        gitsigns.enable = true;
        impl.enable = true;
        refactoring.enable = true;
        statix.enable = true;
        textlint = {
          enable = true;
          package = textLintPackage;
        };
      };
      diagnostics = {
        actionlint.enable = true;
        commitlint.enable = false;
        #commitlint.enable = true;
        deadnix.enable = true;
        editorconfig_checker.enable = true;
        markdownlint.enable = true;
        statix.enable = true;
        textlint = {
          enable = true;
          package = textLintPackage;
        };
      };
      formatting.treefmt.enable = true;
    };
  };
}
