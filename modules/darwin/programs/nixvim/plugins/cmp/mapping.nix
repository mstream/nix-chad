{
  chadLib,
  kms,
  ...
}:
let
  cmpLuaRecordDereference =
    keyString:
    with chadLib.lua.ast;
    recordDereference {
      key = string keyString;
      record = identifier "cmp";
    };

  customMappingActionLuaFunctionDefinition =
    body:
    with chadLib.lua.ast;
    functionDefinition {
      inherit body;
      arguments = [ "fallback" ];
    };

  cmpMappingLuaFunctionInvocation =
    parameters:
    with chadLib.lua.ast;
    functionInvocation {
      inherit parameters;
      function = cmpLuaRecordDereference "mapping";
    };

  actionForAllModesLuaFunctionInvocation =
    body: modes:
    with chadLib.lua.ast;
    cmpMappingLuaFunctionInvocation [
      (customMappingActionLuaFunctionDefinition body)
      (array (chadLib.core.map string modes))
    ];

  actionPerModeLuaFunctionInvocation =
    bodyStatementsByMode:
    with chadLib.lua.ast;
    cmpMappingLuaFunctionInvocation [
      (record {
        entries = chadLib.attrsets.mapAttrs (chadLib.functions.constant customMappingActionLuaFunctionDefinition) bodyStatementsByMode;
      })
    ];

  confirmLuaFunctionInvocation =
    replace: select:
    with chadLib.lua.ast;
    let
      replaceEntries =
        if replace then
          { }
        else
          {
            replace = recordDereference {
              key = string "Replace";
              record = cmpLuaRecordDereference "ConfirmBehavior";
            };
          };
      selectEntries = {
        select = boolean select;
      };
    in
    functionInvocation {
      function = cmpLuaRecordDereference "confirm";
      parameters = [
        (record { entries = replaceEntries // selectEntries; })
      ];
    };

  # TODO: make the argument accept only a valid enum
  selectItemLuaFunctionInvocation =
    nextOrPrev:
    with chadLib.lua.ast;
    functionInvocation {
      function = cmpLuaRecordDereference "select_${nextOrPrev}_item";
      parameters = [
        (record {
          entries = {
            behavior = recordDereference {
              key = string "Select";
              record = cmpLuaRecordDereference "SelectBehavior";
            };
          };
        })
      ];
    };

  selectNextItemLuaFunctionInvocation = selectItemLuaFunctionInvocation "next";
  selectPreviousItemLuaFunctionInvocation = selectItemLuaFunctionInvocation "prev";
in
chadLib.core.mapAttrs (chadLib.functions.constant chadLib.lua.render) (
  with kms.uncategorized;
  {
    ${selectNext} = actionPerModeLuaFunctionInvocation {
      c = [ selectNextItemLuaFunctionInvocation ];
      i = chadLib.lua.ast._raw ''
        local luasnip = require "luasnip"
        if cmp.visible() then
          ${chadLib.lua.render selectNextItemLuaFunctionInvocation}
        elseif luasnip.jumpable(1) then
          luasnip.jump(1)
        end
      '';
    };
    ${scrollDown} =
      actionForAllModesLuaFunctionInvocation
        (chadLib.lua.ast._raw ''
          if cmp.visible() then
            cmp.scroll_docs(-4)
          else
            fallback()
          end
        '')
        [
          "c"
          "i"
          "s"
        ];
    ${selectPrevious} = actionPerModeLuaFunctionInvocation {
      c = [ selectPreviousItemLuaFunctionInvocation ];
      i = chadLib.lua.ast._raw ''
        local luasnip = require "luasnip"
        if cmp.visible() then
          ${chadLib.lua.render selectPreviousItemLuaFunctionInvocation}
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      '';
    };
    ${scrollUp} =
      actionForAllModesLuaFunctionInvocation
        (chadLib.lua.ast._raw ''
          if cmp.visible() then
            cmp.scroll_docs(4)
          else
            fallback()
          end
        '')
        [
          "c"
          "i"
          "s"
        ];
    ${confirm} = actionPerModeLuaFunctionInvocation {
      c = chadLib.lua.ast._raw ''
        if cmp.visible() and cmp.get_active_entry() then
          ${chadLib.lua.render (confirmLuaFunctionInvocation true false)}
        else
          fallback()
        end
      '';
      i = chadLib.lua.ast._raw ''
        if cmp.visible() and cmp.get_active_entry() then
          ${chadLib.lua.render (confirmLuaFunctionInvocation true false)}
        else
          fallback()
        end
      '';
      s = [
        (confirmLuaFunctionInvocation false true)
      ];
    };
  }
)
