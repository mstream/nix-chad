{
  chadLib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.chad;
in
{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        lspFallback = true;
        timeout = 500;
      };
      notify_on_error = true;
      formatters = {
        dhall = {
          command = chadLib.meta.getExe pkgs.dhall;
          stdin = false;
        };
        nixfmt = {
          args = [
            "--width"
            (builtins.toString cfg.editor.documentWidth)
          ];
          command = chadLib.meta.getExe pkgs.nixfmt-rfc-style;
        };
      };
      formatters_by_ft = {
        dhall = [ "dhall" ];
        nix = [ "nixfmt" ];
      };
    };
  };
}
