{
  description = "My Nix MacOS Environment";

  inputs = {
    nix-chad.url = "path:../..";
  };

  outputs =
    { nix-chad, ... }:
    let
      config = {
        user = {
          email = "maciej.laciak@gmail.com";
          name = "mstream";
        };
      };
    in
    nix-chad.lib.chad config;
}
