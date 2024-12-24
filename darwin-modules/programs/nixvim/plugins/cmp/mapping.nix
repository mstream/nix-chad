{
  kms,
  lib,
  nix-to-lua,
  ...
}:
let
  customMappingActionLua =
    body:
    nix-to-lua.inline.types.function-unsafe.mk {
      inherit body;
      args = [ "fallback" ];
    };

  actionForAllModes =
    body: modes:
    let
      actionLuaString = nix-to-lua.uglyLua (customMappingActionLua body);
      modesLuaString = nix-to-lua.uglyLua modes;
    in
    "cmp.mapping(${actionLuaString},${modesLuaString})";

  actionPerMode =
    bodyByMode:
    let
      actionPerMode = lib.attrsets.mapAttrs (
        _: customMappingActionLua
      ) bodyByMode;
      actionPerModeLuaString = nix-to-lua.uglyLua actionPerMode;
    in
    "cmp.mapping(${actionPerModeLuaString})";

  confirm =
    replace: select:
    let
      behaviorString =
        if replace then "replace=cmp.ConfirmBehavior.Replace," else "";
      selectString = lib.strings.concatStrings [
        "select="
        (if select then "true" else "false")
      ];
    in
    "cmp.confirm({${behaviorString}${selectString}})";
in
{
  "${kms.topLevel.selectNext.combination}" =
    actionForAllModes
      ''
        local luasnip = require "luasnip"
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.jumpable(1) then
          luasnip.jump(1)
        end
      ''
      [
        "c"
        "i"
        "s"
      ];
  "${kms.topLevel.scrollDown.combination}" =
    actionForAllModes
      ''
        if cmp.visible() then
          cmp.mapping.scroll_docs(-4)
        else
          fallback()
        end
      ''
      [
        "c"
        "i"
        "s"
      ];
  "${kms.topLevel.selectPrevious.combination}" =
    actionForAllModes
      ''
        local luasnip = require "luasnip"
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      ''
      [
        "c"
        "i"
        "s"
      ];
  "${kms.topLevel.scrollUp.combination}" =
    actionForAllModes
      ''
        if cmp.visible() then
          cmp.mapping.scroll_docs(4)
        else
          fallback()
        end
      ''
      [
        "c"
        "i"
        "s"
      ];
  "<CR>" = actionPerMode {
    c = ''
      if cmp.visible() then
        ${confirm true true}
      else
        fallback()
      end
    '';
    i = ''
      if cmp.visible() and cmp.get_active_entry() then
        ${confirm true false}
      else
        fallback()
      end
    '';
    s = ''
      ${confirm false true}
    '';
  };
}
