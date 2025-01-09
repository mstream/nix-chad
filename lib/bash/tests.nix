implementation: {
  testEchoError = {
    expr = implementation.echoError "abc def";
    expected = "echo \"abc def\" >&2";
  };
  testCatchErrorExec = {
    expr = implementation.catchErrorExec [
      "echo abc"
      "exit 1"
    ];
    expected = "set +e; cmd_out=$(echo abc; exit 1 2>&1); cmd_ret=$?; set -e";
  };
  testMatchPattern = {
    expr = implementation.matchPattern {
      pattern = "a([[:lower:]])c?";
      text = "ab";
    };
    expected = "[[ ab =~ a([[:lower:]])c? ]]";
  };
  testRefs = {
    expr = {
      inherit (implementation.refs) output returnCode;
      fullPatternMatch = implementation.refs.patternMatch 0;
      secondPatternMatchGroup = implementation.refs.patternMatch 2;
    };
    expected = {
      fullPatternMatch = "\${BASH_REMATCH[0]}";
      output = "\${cmd_out}";
      returnCode = "\${cmd_ret}";
      secondPatternMatchGroup = "\${BASH_REMATCH[2]}";
    };
  };
}
