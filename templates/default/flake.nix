{
  description = "My Nix MacOS Environment";

  inputs = { nix-chad.url = "github:mstream/nix-chad/main"; };

  outputs = { nix-chad, ... }:
    let
      config = {
        # Browser bookmarks
        browserBookmarks = [ ];

        # An ID of a key to be used for GPG signing by default.
        # This is expected to be different for individuals.
        # The key is not part of this repository and has to be provided
        # manually.
        defaultGpgKey = "BE318F09150F6CB0724FFEC0319EE1D7FC029354";
        extraPackages = [ "cowsay" ];

        # A desired font size in tools that have a mean to set it fixed.
        fontSize = 24;

        # A list of desirect directories to be created in the home
        # directory of the user.
        # It is up to the user to provide the contents of these
        # directories.
        homeDirectories = [
          "Development/exercises"
          "Development/presentations"
          "Development/projects"
        ];

        # Treat caps lock key as Escape key
        remapCapsLock = true;

        # Treat left arrow key as right Control key 
        remapLeftArrow = false;
        
        # This should be set to the desired user name.
        username = "my-user";

        # Additional initialization for your ZSH sessions
        zshInitExtra = ''
          export VAR1=val1
          export VAR2=val2
        '';
      };
    in nix-chad.lib.chad config;
}
