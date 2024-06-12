{ pkgs, ... }:
with pkgs.lib;
let
  chadPath = builtins.toString ../../..;

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
  options = builtins.removeAttrs evaluatedModules.options [ "_module" ];
  transformOptions =
    opt:
    let
      substituteDeclaration =
        decl:
        if hasPrefix chadPath (builtins.toString decl) then
          gitHubDeclaration {
            ref = "main";
            repo = "nix-chad";
            subpath = removePrefix "/" (removePrefix chadPath (builtins.toString decl));
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
    opt // { declarations = map substituteDeclaration opt.declarations; };
}
