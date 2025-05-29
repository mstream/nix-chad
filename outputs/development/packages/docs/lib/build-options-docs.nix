{ chadLib, pkgs, ... }:
let
  chadPath = chadLib.core.toString ../../..;
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
{ chadEvaluatedModules, nixpkgsRef }:
pkgs.buildPackages.nixosOptionsDoc {
  options = chadLib.core.removeAttrs chadEvaluatedModules.options [
    "_module"
  ];
  transformOptions =
    opt:
    let
      substituteDeclaration =
        decl:
        if chadLib.strings.hasPrefix chadPath (chadLib.core.toString decl) then
          gitHubDeclaration {
            ref = "main";
            repo = "nix-chad";
            subpath = chadLib.strings.removePrefix "/" (
              chadLib.strings.removePrefix chadPath (chadLib.core.toString decl)
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
      declarations = chadLib.core.map substituteDeclaration opt.declarations;
    };
}
