{ easy-ps, pkgs, version, ... }:
let
  userConfig = import ./modules/home-manager/user-config.nix;
  actual = userConfig
    { inherit easy-ps pkgs version; }
    {
      defaultGpgKey = "gpg1";
      fontSize = 123;
      homeDirectories = [ "dir1/dirA" "dir1/dirB" "dir2/dirA" ];
      username = "user1";
    };
in
pkgs.lib.runTests
{
  testHomeFiles = {
    expected = {
      gnupgGpgAgent = {
        recursive = true;
        target = ".gnupg/gpg-agent.conf";
        text = ''
          enable-ssh-support
          default-cache-ttl 60
          max-cache-ttl 120
        '';
      };
      gnupgSshControl = {
        recursive = true;
        target = ".gnupg/sshcontrol";
        text = ''
          gpg1
        '';
      };
      homeDirectory0 = {
        recursive = true;
        target = "dir1/dirA/.keep";
        text = "";
      };
      homeDirectory1 = {
        recursive = true;
        target = "dir1/dirB/.keep";
        text = "";
      };
      homeDirectory2 = {
        recursive = true;
        target = "dir2/dirA/.keep";
        text = "";
      };
    };
    expr = actual.home.file;
  };
}
