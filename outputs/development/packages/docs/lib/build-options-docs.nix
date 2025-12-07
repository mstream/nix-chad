{ chadLib, pkgs, ... }:
let
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
{ chadEvaluatedModules }:
pkgs.buildPackages.nixosOptionsDoc {
  options = chadLib.core.removeAttrs chadEvaluatedModules.options [
    "_module"
  ];
  transformOptions =
    opt:
    let
      substituteDeclaration =
        decl:
        let
          declPathSegments = chadLib.strings.splitString "/" (
            chadLib.core.toString decl
          );
        in
        if
          chadLib.lists.take 3 declPathSegments == [
            ""
            "nix"
            "store"
          ]
        then
          gitHubDeclaration {
            ref = "main";
            repo = "nix-chad";
            subpath = chadLib.strings.concatStringsSep "/" (
              chadLib.lists.drop 4 declPathSegments
            );
            user = "mstream";
          }
        else
          decl;
    in
    opt
    // {
      declarations = chadLib.core.map substituteDeclaration opt.declarations;
    };
}
