{
  description = "My Nix MacOS Environment";

  inputs = { nix-chad.url = "path:../.."; };

  outputs = { nix-chad, ... }:
    let
      config = {
        defaultGpgKey = "BE318F09150F6CB0724FFEC0319EE1D7FC029354";
        extraPackages = [ "cowsay" ];
        fontSize = 24;
        homeDirectories = [
          "Development/exercises"
          "Development/presentations"
          "Development/projects/mstream"
          "Development/projects/other"
          "Development/projects/sky-uk"
        ];
        username = "mstream";
        zshInitExtra = ''
          export DOCKER_HOST=tcp://10.47.140.18:2375
        '';
      };
    in nix-chad.lib.chad config;
}
