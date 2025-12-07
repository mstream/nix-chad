implementation: {
  testKeyCombination = {
    expr = implementation.keyCombination [
      implementation.api.modifierKeys.command
      implementation.api.modifierKeys.shift
    ] implementation.api.otherKeys."0";
    expected = {
      enabled = true;
      value = {
        parameters = [
          48
          29
          (1048576 + 131072)
        ];
        type = "standard";
      };
    };
  };
}
