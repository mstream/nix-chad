{
  actions,
  chadLib,
  kms,
  ...
}:
let
  actionLuaSnippet =
    action:
    let
      luaCode =
        with chadLib.lua.api;
        recordDereference {
          keyExpression = string (actions.mapTo.id action);
          recordExpression = functionInvocation {
            functionExpression = identifier "require";
            parameterExpressions = [ (string "telescope.actions") ];
          };
        };

    in
    chadLib.lua.render luaCode;

  defaultMappingsOverride = chadLib.core.mapAttrs actionLuaSnippet (
    with kms.uncategorized;
    {
      ${selectNext} = actions.members.moveSelectionNext;
      ${selectPrevious} = actions.members.moveSelectionPrevious;
      ${scrollDown} = actions.members.previewScrollDown;
      ${scrollUp} = actions.members.previewScrollUp;
    }
  );
in
{
  mappings = {
    i = defaultMappingsOverride;
    n = defaultMappingsOverride;
  };
  preview = true;
}
