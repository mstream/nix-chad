{ pkgs, system, ... }:
let
  script = "
    set -e
    nix build --experimental-features 'nix-command flakes' --show-trace '.#darwinConfigurations.macbook.${system}.system'
    ./result/sw/bin/darwin-rebuild switch --flake '.#macbook.${system}'
  ";
  scriptBin = pkgs.writeShellScriptBin "switch" script;
in
scriptBin
