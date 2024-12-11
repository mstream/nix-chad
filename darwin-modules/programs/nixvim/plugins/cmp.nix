{ config, nix-to-lua, ... }:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
  customMappingActionLua =
    body:
    nix-to-lua.inline.types.function-unsafe.mk {
      inherit body;
      args = [ "fallback" ];
    };
  standardMappingActionLua =
    body:
    nix-to-lua.inline.types.inline-unsafe.mk {
      inherit body;
    };
  registerMapping =
    actionLua: modes:
    let
      actionLuaString = nix-to-lua.uglyLua actionLua;
      modesLuaString = nix-to-lua.uglyLua modes;
    in
    "cmp.mapping(${actionLuaString},${modesLuaString})";

  registerCustomMapping =
    body: modes: registerMapping (customMappingActionLua body) modes;

  registerStandardMapping =
    body: modes: registerMapping (standardMappingActionLua body) modes;
in
{
  programs.nixvim.plugins.cmp = {
    autoEnableSources = true;
    enable = true;
    settings = {
      mapping = {
        "${kms.topLevel.selectNext.combination}" =
          registerCustomMapping
            ''
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            ''
            [
              "i"
              "s"
            ];
        "${kms.topLevel.scrollDown.combination}" =
          registerStandardMapping "cmp.mapping.scroll_docs(-4)"
            [
              "i"
              "s"
            ];
        "${kms.topLevel.selectPrevious.combination}" =
          registerCustomMapping
            ''
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            ''
            [
              "i"
              "s"
            ];
        "${kms.topLevel.scrollUp.combination}" =
          registerStandardMapping "cmp.mapping.scroll_docs(4)"
            [
              "i"
              "s"
            ];
        "<CR>" =
          "cmp.mapping.confirm({behaviour=cmp.ConfirmBehavior.Replace,select=true})";
        "<C-Space>" = "cmp.mapping.complete()";
      };
    };
  };
}
