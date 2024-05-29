{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dhall.dhall-lang
      dhall.vscode-dhall-lsp-server
      esbenp.prettier-vscode
      haskell.haskell
    ];
  };
}
