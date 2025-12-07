implementation: {
  testCamelToKebabCase = {
    expected = "foo-bar";
    expr = implementation.camelToKebabCase "fooBar";
  };
  testCamelToSnakeCase = {
    expected = "foo_bar";
    expr = implementation.camelToSnakeCase "fooBar";
  };
}
