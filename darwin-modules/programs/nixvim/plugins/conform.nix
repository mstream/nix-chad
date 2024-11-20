{ lib, pkgs, ... }:
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
        nixfmt = {
          command = lib.getExe pkgs.nixfmt-rfc-style;
        };
      };
      formatters_by_ft = {
        nix = [ "nixfmt" ];
      };
    };
  };
}
