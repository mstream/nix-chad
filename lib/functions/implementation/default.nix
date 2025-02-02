chadLib:
let
  compose = chadLib.trivial.flip chadLib.trivial.pipe;
  constant = value: _: value;
  identity = value: value;
  negate = value: !value;
in
{
  inherit
    compose
    constant
    identity
    negate
    ;
}
