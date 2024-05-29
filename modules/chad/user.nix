{ lib, ... }:
with lib; {
  options = {
    chad.user = {
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
}
