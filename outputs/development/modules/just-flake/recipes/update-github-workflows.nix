{
  groups,
  ...
}:
{
  comment = "Run all checks and tests.";
  groups = with groups.members; [
    generation
  ];
  script = ''
    ACTIONS_CHECKOUT="4"
    export ACTIONS_CHECKOUT

    CACHIX_INSTALL_NIX_ACTION="30"
    export CACHIX_INSTALL_NIX_ACTION

    NIXOS="25.05"
    export NIXOS_VERSION

    PEACEIRIS_ACTIONS_GH_PAGES=
    export PEACEIRIS_ACTIONS_GH_PAGES="4"

    UBUNTU="24.04"
    export UBUNTU

    {{call_recipe}} apply-template ".github/workflows" "check" "yml" "actionlint"
  '';
}
