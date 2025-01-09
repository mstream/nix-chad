{  chadLib,
   kms,
  ...
}:
let
  cmpLuaRecordDereference =
    keyString:
    chadLib.lua.api.recordDereference {
      keyExpression = chadLib.lua.api.string keyString;
      recordExpression = chadLib.lua.api.identifier "cmp";
    };

  customMappingActionLuaFunctionDefinition =
    bodyStatements:
    chadLib.lua.api.functionDefinition {
      inherit bodyStatements;
      arguments = [ "fallback" ];
    };

  cmpMappingLuaFunctionInvocation =
    parameterExpressions:
    chadLib.lua.api.functionInvocation {
      inherit parameterExpressions;
      functionExpression = cmpLuaRecordDereference "mapping";
    };

  actionForAllModesLuaFunctionInvocation =
    bodyStatements: modes:
    cmpMappingLuaFunctionInvocation [
      (customMappingActionLuaFunctionDefinition bodyStatements)
      (chadLib.lua.api.array (chadLib.core.map chadLib.lua.api.string modes))
    ];

  actionPerModeLuaFunctionInvocation =
    bodyStatementsByMode:
    cmpMappingLuaFunctionInvocation [
      (chadLib.lua.api.record {
        attrs = chadLib.attrsets.mapAttrs (chadLib.functions.constant customMappingActionLuaFunctionDefinition) bodyStatementsByMode;
      })
    ];

  confirmLuaFunctionInvocation =
    replace: select:
    let
      replaceAttrs =
        if replace then
          { }
        else
          {
            replace = chadLib.lua.api.recordDereference {
                keyExpression = chadLib.lua.api.string "Replace";
                recordExpression = cmpLuaRecordDereference "ConfirmBehavior";
            };
          };
      selectAttrs = {
        select = chadLib.lua.api.boolean select;
      };
    in
    chadLib.lua.api.functionInvocation {
      functionExpression = cmpLuaRecordDereference "confirm";
      parameterExpressions = [
        (chadLib.lua.api.record {
          attrs = replaceAttrs // selectAttrs;
        })
      ];
    };

  # TODO: make the argument accept only a valid enum
  selectItemLuaFunctionInvocation =
    nextOrPrev:
    chadLib.lua.api.functionInvocation {
      functionExpression = cmpLuaRecordDereference "select_${nextOrPrev}_item";
      parameterExpressions = [
        (chadLib.lua.api.record {
          attrs = {
            behavior = chadLib.lua.api.recordDereference {
                keyExpression = chadLib.lua.api.string "Select";
                recordExpression = cmpLuaRecordDereference "SelectBehavior";
            };
          };
        })
      ];
    };

  selectNextItemLuaFunctionInvocation = selectItemLuaFunctionInvocation "next";
  selectPreviousItemLuaFunctionInvocation = selectItemLuaFunctionInvocation "prev";
in
chadLib.core.mapAttrs (chadLib.functions.constant chadLib.lua.render) {
  "${kms.topLevel.selectNext.combination}" =
    actionPerModeLuaFunctionInvocation
      {
        c = [ selectNextItemLuaFunctionInvocation ];
        i = [
          (chadLib.lua.api.raw ''
            local luasnip = require "luasnip"
            if cmp.visible() then
              ${chadLib.lua.render selectNextItemLuaFunctionInvocation}        
            elseif luasnip.jumpable(1) then
              luasnip.jump(1)
            end
          '')
        ];
      };
  "${kms.topLevel.scrollDown.combination}" =
    actionForAllModesLuaFunctionInvocation
      [
        (chadLib.lua.api.raw ''
          if cmp.visible() then
            cmp.scroll_docs(-4)
          else
            fallback()
          end
        '')
      ]
      [
        "c"
        "i"
        "s"
      ];
  "${kms.topLevel.selectPrevious.combination}" =
    actionPerModeLuaFunctionInvocation
      {
        c = [ selectPreviousItemLuaFunctionInvocation ];
        i = [
          (chadLib.lua.api.raw ''
            local luasnip = require "luasnip"
            if cmp.visible() then
              ${chadLib.lua.render selectPreviousItemLuaFunctionInvocation}
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            end
          '')
        ];
      };
  "${kms.topLevel.scrollUp.combination}" =
    actionForAllModesLuaFunctionInvocation
      [
        (chadLib.lua.api.raw ''
          if cmp.visible() then
            cmp.scroll_docs(4)
          else
            fallback()
          end
        '')
      ]
      [
        "c"
        "i"
        "s"
      ];
  "<CR>" = actionPerModeLuaFunctionInvocation {
    c = [
      (chadLib.lua.api.raw ''
        if cmp.visible() and cmp.get_active_entry() then
          ${chadLib.lua.render (confirmLuaFunctionInvocation true false)}
        else
          fallback()
        end
      '')
    ];
    i = [
      (chadLib.lua.api.raw ''
        if cmp.visible() and cmp.get_active_entry() then
          ${chadLib.lua.render (confirmLuaFunctionInvocation true false)}
        else
          fallback()
        end
      '')
    ];
    s = [
      (confirmLuaFunctionInvocation false true)
    ];
  };
}
