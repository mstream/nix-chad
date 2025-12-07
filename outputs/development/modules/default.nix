{
  chadLib,
  chadLibBundle,
  inputs,
  ...
}:
{
  imports = [
    ./dev-shells.nix
    ./just-flake
    ./lint-nix.nix
    ./nix-unit.nix
    ./treefmt-nix.nix
  ];
  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowBroken = false;
          allowUnfree = true;
        };
        overlays = import ../../../overlays/nixpkgs.nix inputs;
      };

      packages = rec {
        docs = pkgs.callPackage ../packages/docs {
          inherit chadLib chadLibBundle vale;
        };
        vale = pkgs.callPackage ../packages/vale { inherit chadLib; };
        website = pkgs.callPackage ../packages/website { inherit docs; };
      };
    };
}
