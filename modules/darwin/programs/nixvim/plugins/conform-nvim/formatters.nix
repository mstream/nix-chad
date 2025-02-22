{
  chadLib,
  documentWidth,
  pkgs,
  ...
}:
chadLib.enum.create {
  mappings = {
    config = {
      dhall = {
        command = chadLib.meta.getExe pkgs.dhall;
        stdin = false;
      };
      googleJavaFormat = {
        command = chadLib.meta.getExe pkgs.google-java-format;
      };
      nixfmt = {
        args = [
          "--width"
          (builtins.toString documentWidth)
        ];
        command = chadLib.meta.getExe pkgs.nixfmt-rfc-style;
      };
      prettier = {
        command = chadLib.meta.getExe pkgs.nodePackages.prettier;
      };
      ruff = {
        args = [
          "format"
          "-"
        ];
        command = chadLib.meta.getExe pkgs.ruff;
        stdin = true;
      };
      shfmt = {
        command = chadLib.meta.getExe pkgs.shfmt;
      };
    };

    fileTypes = {
      dhall = [ "dhall" ];
      googleJavaFormat = [ "java" ];
      nixfmt = [ "nix" ];
      prettier = [ "css" ];
      ruff = [ "python" ];
      shfmt = [
        "bash"
        "sh"
      ];
    };

    name = {
      dhall = "dhall";
      googleJavaFormat = "google-java-format";
      nixfmt = "nixfmt";
      prettier = "prettier";
      ruff = "ruff";
      shfmt = "shftmt";
    };
  };

  memberNames = [
    "dhall"
    "googleJavaFormat"
    "nixfmt"
    "prettier"
    "ruff"
    "shfmt"
  ];

  name = "formatters";
}
