{ pkgs, system, ... }:
let
  script = ''
    set -e
    set -x

    function apply_configuration() {
      local CONFIGURATION=".#macbook.${system}"

      sudo ./result/sw/bin/darwin-rebuild switch \
        --flake \
        --print-build-logs \
        --show-trace \
        "$CONFIGURATION" 
    }

    function build_configuration() {
      local INSTALLABLE=".#darwinConfigurations.macbook.${system}.system"
      nix build \
        --experimental-features 'nix-command flakes' \
        --print-build-logs \
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
