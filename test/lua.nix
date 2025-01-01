{ chadLib, ... }:
let
  inherit
    (import ../lib/lua.nix {
      inherit (chadLib) core;
      nixpkgsLib = chadLib;
    })
    renderAttrs
    ;

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
  attrsRenderingEscaping = {
    expr = renderAttrs { foo = "\\"; };
    expected = ''
      {
          foo =
              "\\"
          ,
      }
    '';
  };

  attrsRenderingSimple = {
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

  attrsRenderingNested = {
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
