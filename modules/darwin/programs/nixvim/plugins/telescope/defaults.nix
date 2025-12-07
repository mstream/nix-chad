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
        with chadLib.lua.ast;
        recordDereference {
          key = string (actions.mapTo.id action);
          record = functionInvocation {
            function = identifier "require";
            parameters = [ (string "telescope.actions") ];
          };
        };

    in
    chadLib.lua.render luaCode;

  defaultMappingsOverride =
    chadLib.attrsets.concatMapAttrs
      (sequence: action: { ${sequence}.__raw = actionLuaSnippet action; })
      (
        with kms.uncategorized;
        {
          ${selectNext} = actions.members.moveSelectionNext;
          ${selectPrevious} = actions.members.moveSelectionPrevious;
          ${scrollDown} = actions.members.previewScrollingDown;
          ${scrollUp} = actions.members.previewScrollingUp;
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
