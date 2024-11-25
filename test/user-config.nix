{ pkgs, ... }:
with pkgs.lib;
let
  evalUserConfigModule =
    chadConfig:
    evalModules {
      modules = [
        {
          _module.args = {
            inherit pkgs;
            osConfig = {
              chad = chadConfig;
            };
          };
        }
        { _module.check = false; }
        ../darwin-modules/home-manager/user-config.nix
      ];
    };

  createTestCase =
    testCaseTitle: getConfigFragment: chadConfig: expected:
    let
      evaluatedUserConfig = evalUserConfigModule chadConfig;
      actual = getConfigFragment evaluatedUserConfig;
    in
    {
      "${testCaseTitle}" = {
        inherit expected;
        expr = actual;
      };
    };

  homeDirectoryTestCase =
    createTestCase "homeDirectoryFiles"
      (config: (trace config.config config).home.file)
      {
        gpg.defaultKey = "gpg1";
        extraPackages = pkgs: [ pkgs.cowsay ];
        fontSize = 123;
        nixpkgsReleaseVersion = "YY.MM";
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
          text = "lol";
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
in
foldl' (acc: testCase: acc // testCase) { } [
  homeDirectoryTestCase
]
