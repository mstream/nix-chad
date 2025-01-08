{ config, ... }:
let
  cfg = config.chad;
  inherit (cfg.editor) documentWidth;
in
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalStatus = true;
        icons_enabled = true;
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          {
            __unkeyed-1 = "filename";
            path = 1;
            shorting_target = documentWidth;
          }
          "diff"
        ];
        lualine_x = [
          "diagnostics"
          "encoding"
          "fileformat"
          "filetype"
        ];
      };
    };
  };
}
