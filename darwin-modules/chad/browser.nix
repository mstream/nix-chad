{ lib, ... }:
with lib;
let
  bookmarkModule = types.addCheck (
    types.submodule (
      { name, ... }:
      {
        options = {
          name = mkOption {
            type = types.str;
            default = name;
            description = "Bookmark name.";
          };

          tags = mkOption {
            type = types.listOf types.str;
            default = [ ];
            description = "Bookmark tags.";
          };

          keyword = mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "Bookmark search keyword.";
          };

          url = mkOption {
            type = types.str;
            description = "Bookmark url, use %s for search terms.";
          };
        };
      }
    )
    // {
      description = "bookmark submodule";
    }
  ) (x: x ? "url");

  directoryModule =
    types.submodule (
      { name, ... }:
      {
        options = {
          name = mkOption {
            type = types.str;
            default = name;
            description = "Directory name.";
          };

          bookmarks = mkOption {
            type = types.listOf nodeModule;
            default = [ ];
            description = "Bookmarks within directory.";
          };

          toolbar = mkOption {
            type = types.bool;
            default = false;
            description = ''
              Make this the toolbar directory. Note, this does _not_
              mean that this directory will be added to the toolbar,
              this directory _is_ the toolbar.
            '';
          };
        };
      }
    )
    // {
      description = "directory submodule";
    };

  nodeModule = types.either bookmarkModule directoryModule;
in
{
  options = {
    chad.browser = {
      bookmarks = mkOption {
        type = types.coercedTo (types.attrsOf nodeModule) builtins.attrValues (
          types.listOf nodeModule
        );
        default = [ ];
        example = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "NixOS Search - Packages";
                keyword = "nixpkgs";
                tags = [ "nix" ];
                url = "https://search.nixos.org/packages";
              }
            ];
          }
          {
            title = "Nix Chad";
            url = "https://github.com/mstream/nix-chad";
          }
        ];
        description = ''
          Browser bookmarks.
        '';
      };
      extraExtensions = mkOption {
        type = types.nullOr (types.functionTo (types.listOf types.package));
        default = null;
        example = literalExpression ''
          exts: with exts; [ honey ];
        '';
        description = ''
          Additional Firefox extensions to be installed for the user.
        '';
      };
    };
  };
}
