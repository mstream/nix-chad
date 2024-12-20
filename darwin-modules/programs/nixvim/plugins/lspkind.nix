{ nix-to-lua, ... }:
let
  after =
    body:
    nix-to-lua.uglyLua (
      nix-to-lua.inline.types.function-unsafe.mk {
        inherit body;
        args = [
          "entry"
          "vim_item"
          "kind"
        ];
      }
    );
in
{
  programs.nixvim.plugins.lspkind = {
    cmp = {
      after = after ''
        local strings = vim.split(kind.kind, " ") 

        if #strings == 1 then
            kind.kind = "   "
            kind.menu = "    (" .. strings[1] .. ")"
        else
            kind.kind = " " .. strings[1] .. " " 
            kind.menu = "    (" .. strings[2] .. ")"
        end

        return kind
      '';
      ellipsisChar = "...";
      enable = true;
      maxWidth = 16;
    };
    enable = true;
    mode = "symbol_text";
  };
}
