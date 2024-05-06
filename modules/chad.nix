{ config, lib, ... }:
with lib;
let
  cfg = config.chad;
  bookmarkModule = {
    options = {
      title = { type = types.str; };
      url = { type = types.str; };
    };
  };
  keyBindingModule = {
    options = {
      chars = { type = types.str; };
      key = { type = types.str; };
      mods = { type = types.str; };
    };
  };
in {
  options = {
    chad = {
      browser = {
        bookmarks = mkOption {
          type = types.listOf (types.submodule bookmarkModule);
          default = [ ];
          example = [{
            title = "Nix Chad";
            url = "https://github.com/mstream/nix-chad";
          }];
          description = ''
            Browser bookmarks.
            Not supported until there is a nix-native browser for 
            Apple Silicon available.
          '';
        };
      };
      extraPackages = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [ "cowsay" ];
        description = ''
          Additional nixpkgs packages to be accessible for the user.
        '';
      };
      fontSize = mkOption {
        type = types.int;
        default = 12;
        example = 16;
        description = ''
          A desired font size in tools that have means to set it fixed.
        '';
      };
      gpg = {
        defaultKey = mkOption {
          type = types.nullOr types.str;
          default = null;
          example = "BE318F09150F6CB0724FFEC0319EE1D7FC029354";
          description = ''
            An ID of a key to be used for GPG signing by default.
            This is expected to be different for individuals.
            The key is not part of this repository and has to be provided
            manually.
          '';
        };
      };
      keyboard = {
        remapCapsLock = mkOption {
          type = types.bool;
          default = true;
          description = ''
            Treat Caps Lock key as Escape key.
          '';
        };
        remapLeftArrow = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Treat Left Arrow key as Right Control key.
          '';
        };
      };
      manageWindows = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Keep windows occupy maximum available share of space on desktop.
          '';
        };
        exclusions = mkOption {
          type = types.listOf types.str;
          default = [ ];
          example = [ "Discord" ];
          description = ''
            List of application names for which automatic 
            window management should not be performed.
          '';
        };
      };
      terminal = {
        keyBindings = mkOption {
          type = types.listOf (types.submodule keyBindingModule);
          default = [ ];
          example = [{
            chars = "\\u000c";
            key = "K";
            mods = "Control";
          }];
          description = ''
            Additonal key bindings for terminal emulator. 
          '';
        };
        zshInitExtra = mkOption {
          type = types.lines;
          default = "";
          example = ''
            export VAR1=val1  
            export VAR2=val2
          '';
          description = ''
            Additional initialization for ZSH sessions.
          '';
        };
      };
      user = {
        homeDirectories = mkOption {
          type = types.listOf types.str;
          default = [ ];
          example = [
            "Development/exercises"
            "Development/presentations"
            "Development/projects"
          ];
          description = ''
            A list of desirect directories to be created in the home
            directory of the user.
            It is up to the user to provide the contents of these
            directories.
          '';
        };
        name = mkOption {
          type = types.str;
          example = "bob";
          description = ''
            User name.
          '';
        };
      };
    };
  };
  config = {
    users.users."${cfg.user.name}" = {
      home = "/Users/${cfg.user.name}";
      inherit (cfg.user) name;
    };
  };
}
