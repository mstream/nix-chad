{ pkgs, ... }:
let
  docs = import ./docs.nix { inherit pkgs; };
  lua = import ./lua.nix { inherit pkgs; };
  userConfig = import ./user-config.nix { inherit pkgs; };
  zshAbbreviations = import ./zsh-abbreviations.nix { inherit pkgs; };
in
pkgs.lib.runTests (docs // lua // userConfig // zshAbbreviations)
