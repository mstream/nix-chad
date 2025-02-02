implementation:
let
  double = value: 2 * value;
  addTen = value: 10 + value;
  alwaysNine = implementation.constant 9;
in
{
  testCompose = {
    expr = implementation.compose [ double addTen ] 3;
    expected = 16;
  };
  testConstant = {
    expr = alwaysNine "ignored";
    expected = 9;
  };
  testIdentity = {
    expr = implementation.identity "arbitrary";
    expected = "arbitrary";
  };
  testNegateFalse = {
    expr = implementation.negate false;
    expected = true;
  };
  testNegateTrue = {
    expr = implementation.negate true;
    expected = false;
  };
}
