{
  groups,
  nixBuildCommand,
  ...
}:

{
  comment = "Run tests using example nix-chad setups.";
  groups = with groups.members; [
    test
  ];
  script = ''
    if [[ "{{ci}}" = "true" ]]; then
      echo "CI runs on Linux machines as MacOS ones are 10 times as expensive."
      echo "Therefore, this suite of test will be executed only from development machine."
      echo "Skipping integration tests..."
      exit 0
    fi

    cd "{{repo_root}}/examples/minimal"
    nix flake update
    ${nixBuildCommand ".#{{conf_attr}}"}

    cd "{{repo_root}}/examples/custom"
    nix flake update
    ${nixBuildCommand ".#{{conf_attr}}"}

    cd "$(mktemp -d)"
    nix flake init --template "{{repo_root}}"
    sed "s%github:{{github_repo}}/main%git+file:{{repo_root}}?shallow=1%g" flake.nix >tmp.nix && mv tmp.nix flake.nix
    nix flake update
    ${nixBuildCommand ".#{{conf_attr}}"}
  '';
}
