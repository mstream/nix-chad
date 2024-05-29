{ lib, ... }:
with lib;

let
  bookmarkModule = {
    options = {
      title = mkOption {
        type = types.str;
        description = ''
          Title of the bookmark.
        '';
      };
      url = mkOption {
        type = types.str;
        description = ''
          URL of the bookmark.
        '';
      };
    };
  };

in {
  options = {
    chad.browser = {
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
  };
}
