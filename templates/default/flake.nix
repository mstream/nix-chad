# Useful commands
#
# Updating nix-chad version: 
# `nix flake update`
#
# Applying nix-chad configuration: 
# `nix run .#switch`
# --------------------------------

{
  description = "My Nix MacOS Environment";

  inputs = {
    nix-chad.url = "github:mstream/nix-chad/main";
  };

  outputs =
    { nix-chad, ... }:
    let
      config = {
        browser = {
          # Browser bookmarks
          # Not supported until there is a nix-native browser for 
          # Apple Silicon available.
          bookmarks = [ ];
        };

        # Additional nixpkgs packages to be accessible for the user.
        extraPackages = pkgs: with pkgs; [ ];

        # A desired font size in tools that have means to set it fixed.
        fontSize = 12;

        gpg = {
          # An ID of a key to be used for GPG signing by default.
          # This is expected to be different for individuals.
          # The key is not part of this repository and has to be provided
          # manually.
          defaultKey = "BE318F09150F6CB0724FFEC0319EE1D7FC029354";
        };

        keyboard = {
          # Treat Caps Lock key as Escape key.
          remapCapsLock = true;
          # Treat Left Arrow key as Right Control key.
          remapLeftArrow = false;
        };

        manageWindows = {
          # Keep windows occupy maximum available share of space on desktop.
          enable = false;
          # List of application names for which automatic window management
          # should not be performed.
          exclusions = [ ];
        };

        mouse = {
          # Should content scroll opposite to the swipe/roll direction. 
          naturalScrollDirection = true;
        };

        software = {
          # Use only Open Source software 
          openSourceOnly = true;
        };

        terminal = {
          abbreviations = {
            # Additional abbreviation for ZSH
            extraAbbreviations = { };
          };
          # Additional key bindings for terminal emulator. 
          keyBindings = [ ];
          # Additional initialization for ZSH sessions.
          zshInitExtra = "";
        };

        user = {
          # A list of desirect directories to be created in the home
          # directory of the user.
          # It is up to the user to provide the contents of these
          # directories.
          homeDirectories = [ ];

          # User name
          name = "my-user";
        };
      };
    in
    nix-chad.lib.chad config;
}
