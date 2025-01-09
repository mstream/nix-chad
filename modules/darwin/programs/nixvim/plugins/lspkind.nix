{ chadLib, ... }:
let
  afterLuaFunctionDefinition =
    bodyStatements:
    chadLib.lua.api.functionDefinition {
      inherit bodyStatements;
      arguments = [
        "entry"
        "vim_item"
        "kind"
      ];
    };
in
{
  programs.nixvim.plugins.lspkind = {
    cmp = {
      after = chadLib.lua.render (afterLuaFunctionDefinition [
        (chadLib.lua.api.raw ''
          local strings = vim.split(kind.kind, " ") 

          if #strings == 1 then
            kind.kind = "   "
            kind.menu = "    (" .. strings[1] .. ")"
          else
            kind.kind = " " .. strings[1] .. " " 
            if strings[2] == nil then
              kind.menu = ""
            else
              kind.menu = "    (" .. strings[2] .. ")"
            end
          end

          return kind
        '')
      ]);
      ellipsisChar = "...";
      enable = true;
      maxWidth = 16;
    };
    enable = true;
    mode = "symbol_text";
  };
}
