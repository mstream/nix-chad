{
  description = "My Nix MacOS Environment";

  inputs = {
    nix-chad.url = "path:../..";
  };

  outputs =
    { nix-chad, ... }:
    let
      config = {
        browser = {
          bookmarks = [
            {
              title = "Nix Chad";
              url = "https://github.com/mstream/nix-chad";
            }
          ];
        };
        extraPackages = pkgs: [ pkgs.cowsay ];
        fontSize = 16;
        gpg = {
          defaultKey = "BE318F09150F6CB0724FFEC0319EE1D7FC029354";
        };
        keyboard = {
          remapCapsLock = true;
          remapLeftArrow = true;
        };
        manageWindows = {
          enable = true;
          exclusions = [
            {
              app = "^Discord$";
              title = ".*Dialog$";
            }
          ];
        };
        terminal = {
          keyBindings = [ ];
          zshInitExtra = ''
            export VAR1=val1  
            export VAR2=val2
          '';
        };
        user = {
          homeDirectories = [
            "Development/exercises"
            "Development/presentations"
            "Development/projects"
          ];
          name = "bob";
        };
      };
    in
    nix-chad.lib.chad config;
}
