{ pkgs, system, ... }:
let
  script =
    "\n    set -e\n    nix build --experimental-features 'nix-command flakes' --show-trace '.#darwinConfigurations.macbook.${system}.system'\n    ./result/sw/bin/darwin-rebuild switch --flake '.#macbook.${system}'\n  ";
  scriptBin = pkgs.writeShellScriptBin "switch" script;
in scriptBin
