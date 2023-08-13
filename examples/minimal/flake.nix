{
  description = "My Nix MacOS Environment";

  inputs = {
    nix-chad.url = "path:../..";
  };

  outputs = { nix-chad, ... }:
    let
      config =
        {
          username = "mstream";
        };
    in
    nix-chad.lib.chad config;
}
