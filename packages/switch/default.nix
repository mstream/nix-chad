{ pkgs, system, ... }:
let
  script = ''
    set -e
    set -E

    function apply_configuration() {
      local CONFIGURATION=".#macbook.${system}"

      ./result/sw/bin/darwin-rebuild switch \
        --flake \
        "$CONFIGURATION"
    }

    function build_configuration() {
      local INSTALLABLE=".#darwinConfigurations.macbook.${system}.system"

      nix build \
        --experimental-features 'nix-command flakes' \
        --show-trace \
        "$INSTALLABLE"
    }

    function reset_launchpad() {
      defaults write com.apple.dock ResetLaunchPad -bool true 
    }

    build_configuration
    # reset_launchpad
    apply_configuration
  '';
  scriptBin = pkgs.writeShellScriptBin "switch" script;
in
scriptBin
