{ lib, pkgs, ... }:
let
  chadPath = lib.core.toString ../../..;
  gitHubDeclaration =
    {
      ref,
      repo,
      subpath,
      user,
    }:
    {
      url = "https://github.com/${user}/${repo}/blob/${ref}/${subpath}";
      name = "<${repo}/${subpath}>";
    };
in
{ evaluatedModules, nixpkgsRef }:
pkgs.buildPackages.nixosOptionsDoc {
  options = lib.core.removeAttrs evaluatedModules.options [ "_module" ];
  transformOptions =
    opt:
    let
      substituteDeclaration =
        decl:
        if lib.strings.hasPrefix chadPath (lib.core.toString decl) then
          gitHubDeclaration {
            ref = "main";
            repo = "nix-chad";
            subpath = lib.strings.removePrefix "/" (
              lib.strings.removePrefix chadPath (lib.core.toString decl)
            );
            user = "mstream";
          }
        else if decl == "lib/modules.nix" then
          gitHubDeclaration {
            ref = nixpkgsRef;
            repo = "nixpkgs";
            subpath = decl;
            user = "NixOS";
          }
        else
          decl;
    in
    opt
    // {
      declarations = lib.core.map substituteDeclaration opt.declarations;
    };
}
