{
  chadLib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.chad;
  timeoutMs = 500;
  defaultFormatOptions = {
    lsp_format = "fallback";
    quiet = false;
    stop_after_first = false;
    timeout_ms = timeoutMs;
  };
  formatters = import ./formatters.nix {
    inherit chadLib pkgs;
    inherit (cfg.editor) documentWidth;
  };
  allFormatterMembers = chadLib.core.attrValues formatters.members;
  generateWithFormatters = chadLib.attrsets.generate allFormatterMembers;
in
{
  programs.nixvim.plugins.conform-nvim = {
    enable = true;
    settings = {
      default_format_opts = defaultFormatOptions;
      format_on_save = defaultFormatOptions;
      log_level = "warn";
      notify_on_error = true;
      notify_no_formatters = true;
      formatters = generateWithFormatters (
        formatter:
        let
          formatterName = formatters.mapTo.name formatter;
          formatterConfig = formatters.mapTo.config formatter;
        in
        {
          ${formatterName} = formatterConfig;
        }
      );
      formatters_by_ft = generateWithFormatters (
        formatter:
        let
          formatterName = formatters.mapTo.name formatter;
          formatterFileTypes = formatters.mapTo.fileTypes formatter;
        in
        chadLib.attrsets.generate formatterFileTypes (fileType: {
          ${fileType} = [formatterName];
        })
      );
    };
  };
}
