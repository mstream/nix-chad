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
      pursTidy = {
        args = [
          "format"
          "--arrow-first"
          "--config-prefer"
          "--import-sort-ide"
          "--import-wrap-auto"
          "--indent"
          "2"
          "--ribbon"
          "1"
          "--unicode-always"
          "--width"
          (builtins.toString documentWidth)
        ];
        command = chadLib.meta.getExe pkgs.nodePackages.purs-tidy;
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
      pursTidy = [ "purescript" ];
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
      pursTidy = "purs-tidy";
      ruff = "ruff";
      shfmt = "shftmt";
    };
  };

  memberNames = [
    "dhall"
    "googleJavaFormat"
    "nixfmt"
    "prettier"
    "pursTidy"
    "ruff"
    "shfmt"
  ];

  name = "formatters";
}
