{ chadLib, ... }:
let
  gitIdentityModule = {
    options = with chadLib.options; {
      repositoryUrl = mkOption {
        description = ''
          Git repository URL.
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
            repositoryUrl = "git@github.com:somecompany/**";
            sshKeyPath = "~/.ssh/work_id_rsa";
            userEmail = "me@somecompany.com";
          }
        ];
        description = ''
          Alternative Git identities for selected repositories. 
        '';
      };
    };
  };
}
