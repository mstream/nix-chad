{ chadLib, pkgs, ... }:
let
  actions = chadLib.enum.create {
    members = [
      "screenshot"
      "screenshotToClipboard"
      "screenshotRegion"
      "screenshotRegionToClipboard"
    ];
    name = "actions";
  };
  mappings = import ./mappings.nix { inherit actions chadLib; };
  shortcutsSpec = import ./shortcutsSpec.nix { inherit mappings pkgs; };
  updateShortcutsScript = import ./update-shortcuts-script.nix {
    inherit pkgs;
  };
in
{
  system.activationScripts.shortcuts.text = ''
    "${updateShortcutsScript}" "${shortcutsSpec}"
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 999 "<dict><key>enabled</key><false/></dict>"
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
