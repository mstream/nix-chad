implementation: {
  testEchoError = {
    expected = "echo \"abc def\" >&2";
    expr = implementation.echoError "abc def";
  };
  testCatchErrorExec = {
    expected = "set +e; cmd_out=$(echo abc; exit 1 2>&1); cmd_ret=$?; set -e";
    expr = implementation.catchErrorExec [
      "echo abc"
      "exit 1"
    ];
  };
  testCommand = {
    expected = "program --flag --parameter arg";
    expr = implementation.command {
      flags = [ "flag" ];
      parameters = {
        parameter = "arg";
      };
      program = "program";
    };
  };
  testMatchPattern = {
    expected = "[[ \"ab\" =~ a([[:lower:]])c? ]]";
    expr = implementation.matchPattern {
      pattern = "a([[:lower:]])c?";
      text = "ab";
    };
  };
  testOptions = {
    expected = "-f --flag1 --flag2 --parameter1 arg1 --parameter2 arg2";
    expr = implementation.options {
      flags = [
        "f"
        "flag1"
        "flag2"
      ];
      parameters = {
        parameter1 = "arg1";
        parameter2 = "arg2";
      };
    };
  };
  testRefs = {
    expected = {
      fullPatternMatch = "\${BASH_REMATCH[0]}";
      output = "\${cmd_out}";
      returnCode = "\${cmd_ret}";
      secondPatternMatchGroup = "\${BASH_REMATCH[2]}";
    };
    expr = {
      inherit (implementation.refs) output returnCode;
      fullPatternMatch = implementation.refs.patternMatch 0;
      secondPatternMatchGroup = implementation.refs.patternMatch 2;
    };
  };
}
