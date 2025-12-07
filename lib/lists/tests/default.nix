implementation: {
  testIsEmptyAgainstEmptyList = {
    expected = true;
    expr = implementation.isEmpty [ ];
  };
  testIsEmptyAgainstNonEmptyList = {
    expected = false;
    expr = implementation.isEmpty [ "foo" ];
  };
}
