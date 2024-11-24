{ pkgs, ... }:
with pkgs.lib;
let
  userConfig = import ../darwin-modules/home-manager/user-config.nix;
  evalUserConfigModule =
    chadConfig:
    evalModules {
      modules = [
        { _module.check = false; }
        userConfig
      ];
    };
  createTestCase =
    title: getConfigFragment: chadConfig: expected:
    let
      evaluatedUserConfig = evalUserConfigModule chadConfig;
      actual = getConfigFragment evaluatedUserConfig;
    in
    {
      "${title}" = {
        inherit actual expected;
      };
    };
in
builtins.foldl' (acc: testCase: acc // testCase) { } [
  (createTestCase "homeDirectoryFiles" (config: config.home.file)
    {
      gpg.defaultKey = "gpg1";
      extraPackages = pkgs: [ pkgs.cowsay ];
      fontSize = 123;
      software.openSourceOnly = false;
      user = {
        homeDirectories = [
          "dir1/dirA"
          "dir1/dirB"
          "dir2/dirA"
        ];
        name = "user1";
      };
    }
    {
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
    }
  )
]
