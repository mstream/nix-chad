{
  chadLib,
  config,
  nixosVersion,
  ...
}:
let
  cfg = config.chad;
in
{
  config = {
    chad = {
      nixpkgsReleaseVersion = nixosVersion;
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
    nixpkgsReleaseVersion = mkOption {
      type = with chadLib.types; str;
      readOnly = true;
      visible = false;
      example = "24.05";
    };
    selectNextKey = mkOption {
      default = "n";
      readOnly = true;
      type = with chadLib.types; str;
      visible = false;
    };
    selectPreviousKey = mkOption {
      default = "p";
      readOnly = true;
      type = with chadLib.types; str;
      visible = false;
    };
    sslCertFilePath = mkOption {
      type = with chadLib.types; str;
      readOnly = true;
      visible = false;
      example = "/etc/ssl/certs/ca-certificates.crt";
    };
  };
}
