implementation: {
  testKeyWithoutArgs = {
    expected = "foo";
    expr = implementation.key { name = "foo"; };
  };
  testKeyWithStringArg = {
    expected = "foo \"bar\"";
    expr = implementation.key {
      name = "foo";
      args = [ "bar" ];
    };
  };
  testKeyWithNumberArg = {
    expected = "foo 123";
    expr = implementation.key {
      name = "foo";
      args = [ 123 ];
    };
  };
}
