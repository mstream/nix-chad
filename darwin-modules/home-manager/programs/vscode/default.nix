{ osConfig, pkgs, ... }:
let
  cfg = osConfig.chad;
in
{
  programs.vscode = {
    enable = !cfg.software.openSourceOnly;
    extensions = with pkgs.vscode-extensions; [
      dhall.dhall-lang
      dhall.vscode-dhall-lsp-server
      esbenp.prettier-vscode
      haskell.haskell
    ];
  };
}
