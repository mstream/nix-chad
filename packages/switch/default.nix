{ pkgs, system, ... }:
let
  script = ''
    set -e

    nix build \
      --experimental-features "nix-command flakes" \
      --show-trace \
      ".#darwinConfigurations.macbook.${system}.system"

    defaults write com.apple.dock ResetLaunchPad -bool true 

    killall Dock

    ./result/sw/bin/darwin-rebuild switch --flake ".#macbook.${system}"
  '';
  scriptBin = pkgs.writeShellScriptBin "switch" script;
in scriptBin
