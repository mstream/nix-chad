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
              name = "Toolbar";
              toolbar = true;
              bookmarks = [
                {
                  name = "GitHub";
                  keyword = "github";
                  url = "https://github.com/";
                }
              ];
            }
            {
              name = "Nix";
              bookmarks = [
                {
                  name = "NixOS Search - Packages";
                  keyword = "nixpkgs";
                  tags = [
                    "nix"
                    "nixpkgs"
                  ];
                  url = "https://search.nixos.org/packages";
                }
                {
                  name = "Nix User Repositiories";
                  keyword = "nur";
                  tags = [ "nix" ];
                  url = "https://nur.nix-community.org/";
                }
              ];
            }
          ];
          extraExtensions = exts: [ exts.grammarly ];
        };
        editor = {
          lineNumbering = "absolute";
        };
        extraPackages = pkgs: [ pkgs.cowsay ];
        fontSize = 16;
        gpg = {
          defaultKey = "BE318F09150F6CB0724FFEC0319EE1D7FC029354";
        };
        keyboard = {
          disableKeyRepeat = false;
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
        mouse = {
          naturalScrollDirection = true;
        };
        software = {
          openSourceOnly = false;
        };
        terminal = {
          abbreviations = {
            enable = true;
            extraAbbreviations = {
              abbr1 = "some command expansion with optional \"%\" placeholders";
            };
          };
          keyBindings = [
            {
              chars = "\\u000c";
              key = "K";
              mods = "Control";
            }
          ];
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
