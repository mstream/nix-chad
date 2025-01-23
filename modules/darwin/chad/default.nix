{ chadLib, config, ... }:
let
  cfg = config.chad;
in
{
  config = {
    chad = {
      nixpkgsReleaseVersion = "24.11";
      sslCertFilePath = "/etc/nix/ca_cert.pem";
    };
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
    ./terminal.nix
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
    nixpkgsReleaseVersion = mkOption {
      type = with chadLib.types; str;
      readOnly = true;
      visible = false;
      example = "24.05";
    };
    sslCertFilePath = mkOption {
      type = with chadLib.types; str;
      readOnly = true;
      visible = false;
      example = "/etc/ssl/certs/ca-certificates.crt";
    };
  };
}
