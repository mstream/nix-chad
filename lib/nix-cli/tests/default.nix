implementation:
let
  command = "build --show-trace .#someAttr";
in
{
  testRunCommandWithoutShowngFullLogOnErrors = {
    expr = implementation.runCommand {
      inherit command;
      showFullLogsOnError = false;
    };
    expected = "nix build --show-trace .#someAttr";
  };
  testRunCommandWithShowngFullLogOnErrors = {
    expr = implementation.runCommand {
      inherit command;
      showFullLogsOnError = true;
    };
    expected = ''
      set +e; cmd_out=$(nix build --show-trace .#someAttr 2>&1); cmd_ret=$?; set -e
      if [ ''${cmd_ret} -ne 0 ]; then
        if [[ "''${cmd_out}" =~ For[[:space:]]full[[:space:]]logs,[[:space:]]run[[:space:]]\'([^\']+)\'. ]]; then
          echo "Full Nix logs:" >&2
          ''${BASH_REMATCH[1]} >&2
        else
          echo "Nix logs:" >&2
          echo "''${cmd_out}" >&2
        fi
        exit ''${cmd_ret}
      fi
    '';
  };
}
