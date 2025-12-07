{ chadLib, config, ... }:
let
  cfg = config.chad;
  inherit (cfg.manageWindows) enable;
  actions = chadLib.enum.create {
    mappings = {
      value = {
        moveNodeToWorkspace = "workspace";
        switchToWorkspace = "move-node-to-workspace";
      };
    };
    memberNames = [
      "moveNodeToWorkspace"
      "switchToWorkspace"
    ];
    name = "modeGroups";
  };

  genGapSizeAttrs =
    keys: chadLib.attrsets.genAttrs keys (chadLib.functions.constant 16);
in
{
  services.aerospace = {
    inherit enable;
    settings = {
      accordion-padding = 90;
      after-startup-command = [ "layout tiles" ];
      automatically-unhide-macos-hidden-apps = true;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      gaps = {
        inner = genGapSizeAttrs [
          "horizontal"
          "vertical"
        ];
        outer = genGapSizeAttrs [
          "bottom"
          "left"
          "right"
          "top"
        ];
      };
      key-mapping.preset = "qwerty";
      mode.main.binding = import ./binding {
        inherit
          actions
          chadLib
          ;
      };
    };
  };
}
