{ chadLib, config, ... }:
let
  cfg = config.chad;
  inherit (cfg.editor) documentWidth;
  components = import ./components.nix { inherit chadLib documentWidth; };
  refreshInterval = 250;
  sections = import ./sections.nix { inherit chadLib; };
  layout =
    sectionToComponents:
    let
      componentsFor = sections.mapWith sectionToComponents;
    in
    chadLib.attrsets.generate (chadLib.core.attrValues sections.members)
      (section: {
        ${sections.mapTo.key section} = componentsFor section;
      });
in
{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        always_divide_middle = false;
        globalStatus = true;
        icons_enabled = true;
        refresh = {
          statusline = refreshInterval;
          tabline = refreshInterval;
          winbar = refreshInterval;
        };
        theme = "catppuccin";
      };

      sections =
        with components;
        layout {
          a = [ mode ];
          b = [ _blank ];
          c = [ lspStatus ];
          x = [ _blank ];
          y = [
            encoding
            fileFormat
            fileType
          ];
          z = [
            progress
            location
          ];
        };

      tabline =
        with components;
        layout {
          a = [
            cwd
            fileName
          ];
          b = [
            branch
          ];
          c = [
            diff
          ];
          x = [
            _blank
          ];
          y = [
            _blank
          ];
          z = [
            _blank
          ];
        };

      # winbar has to be empty when lsp-saga plugin is enabled
      winbar = layout {
        a = [
        ];
        b = [
        ];
        c = [
        ];
        x = [
        ];
        y = [
        ];
        z = [
        ];
      };
    };
  };
}
