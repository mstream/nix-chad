{
  chadLib,
  config,
  nixosVersion,
  ...
}:
let
  cfg = config.chad;
  universalKeyOption =
    key:
    chadLib.options.mkOption {
      default = key;
      readOnly = true;
      type = with chadLib.types; str;
      visible = false;
    };
in
{
  config = {
    users.users."${cfg.user.name}" = {
      inherit (cfg.user) name;
      home = "/Users/${cfg.user.name}";
    };
  };

  imports = [
    ./browser.nix
    ./editor
    ./git.nix
    ./gpg.nix
    ./keyboard.nix
    ./manage-windows.nix
    ./mouse.nix
    ./software.nix
    ./terminal
    ./user.nix
  ];

  options.chad = with chadLib.options; {
    extraPackages = mkOption {
      type = with chadLib.types; nullOr (functionTo (listOf package));
      default = null;
      example = literalExpression ''
        pkgs: with pkgs; [ cowsay ];
      '';
      description = ''
        Additional nixpkgs packages to be accessible for the user.
      '';
    };
    fontSize = mkOption {
      type = with chadLib.types; int;
      default = 12;
      example = 16;
      description = ''
        A desired font size in tools that have means to set it fixed.
      '';
    };
    initialSetup = mkOption {
      default = false;
      description = ''
        Should be enabled when the switch is run for the first time
      '';
      type = with chadLib.types; bool;
      readOnly = false;
      visible = true;
    };
    moveDownKey = universalKeyOption "j";
    moveLeftKey = universalKeyOption "h";
    moveRightKey = universalKeyOption "l";
    moveUpKey = universalKeyOption "k";
    nixpkgsReleaseVersion = mkOption {
      default = nixosVersion;
      type = with chadLib.types; str;
      readOnly = true;
      visible = false;
      example = "24.05";
    };
    scrollDownKey = universalKeyOption "d";
    scrollUpKey = universalKeyOption "u";
    selectNextKey = universalKeyOption "n";
    selectPreviousKey = universalKeyOption "p";
    sslCertFilePath = mkOption {
      default = "/etc/nix/ca_cert.pem";
      type = with chadLib.types; str;
      readOnly = true;
      visible = false;
      example = "/etc/ssl/certs/ca-certificates.crt";
    };
  };
}
