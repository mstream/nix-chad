{ lib, ... }:
with lib;
let
  gitIdentityModule = {
    options = {
      repositoryPath = mkOption {
        type = types.str;
        description = ''
          Git repository path.
        '';
      };
      sshKeyPath = mkOption {
        type = types.str;
        description = ''
          Path to a SSH private key.
        '';
      };
      userEmail = mkOption {
        type = types.str;
        description = ''
          Key.
        '';
      };
    };
  };
in
{
  options = {
    chad.git = {
      alternativeGitIdentities = mkOption {
        type = types.listOf (types.submodule gitIdentityModule);
        default = [ ];
        example = [
          {
            repositoryPath = "~/work/project-1";
            sshKeyPath = "~/.ssh/work_id_rsa";
            userEmail = "me@mail.com";
          }
        ];
        description = ''
          Alternative Git identities for selected repositories. 
        '';
      };
    };
  };
}
