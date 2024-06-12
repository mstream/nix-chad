{ pkgs, ... }:
let
  inherit (import ../lib/lua.nix { inherit pkgs; }) renderAttrs;

  simpleAttrs = {
    someKey11 = "11 value";
    someKey12 = "12 value";
  };

  nestedAttrs = {
    someKey1 = simpleAttrs;
    someKey2 = "2 value";
  };
in
{
  testLuaAttrsRenderingEscaping = {
    expr = renderAttrs { foo = "\\"; };
    expected = ''
      {
          foo =
              "\\"
          ,
      }
    '';
  };

  testLuaAttrsRenderingSimple = {
    expr = renderAttrs simpleAttrs;
    expected = ''
      {
          some_key_1_1 =
              "11 value"
          ,
          some_key_1_2 =
              "12 value"
          ,
      }
    '';
  };

  testLuaAttrsRenderingNested = {
    expr = renderAttrs nestedAttrs;
    expected = ''
      {
          some_key_1 =
              {
                  some_key_1_1 =
                      "11 value"
                  ,
                  some_key_1_2 =
                      "12 value"
                  ,
              }
          ,
          some_key_2 =
              "2 value"
          ,
      }
    '';
  };
}
