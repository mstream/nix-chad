{ pkgs, ... }:
let
  userConfig = import ./user-config.nix { inherit pkgs; };
  zshAbbreviations = import ./zsh-abbreviations.nix { inherit pkgs; };
in pkgs.lib.runTests (userConfig // zshAbbreviations)

