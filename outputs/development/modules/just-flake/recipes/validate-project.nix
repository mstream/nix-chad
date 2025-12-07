{
  groups,
  ...
}:
{
  comment = "Run all checks and tests.";
  groups = with groups.members; [
    check
    test
  ];
  hooks = {
    after = [
      "check-debug"
      "check-generation"
    ];
    before = [
      "run-lints"
      "run-unit-tests"
      "run-integration-tests"
    ];
  };
  script = ''
    echo "Project validation has finished successfully."
  '';
}
