{ chadLib, ... }:
let
  gitIdentityModule = {
    options = with chadLib.options; {
      repositoryPath = mkOption {
        description = ''
          Git repository path.
        '';
        type = with chadLib.types; str;
      };
      sshKeyPath = mkOption {
        description = ''
          Path to a SSH private key.
        '';
        type = with chadLib.types; str;
      };
      userEmail = mkOption {
        description = ''
          Key.
        '';
        type = with chadLib.types; str;
      };
    };
  };
in
{
  options = with chadLib.options; {
    chad.git = {
      alternativeGitIdentities = mkOption {
        type = with chadLib.types; listOf (submodule gitIdentityModule);
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
