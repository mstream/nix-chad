{ osConfig, ... }:
let
  cfg = osConfig.chad;
in
{
  programs.gpg = {
    enable = cfg.gpg.defaultKey != null;
    settings = {
      no-auto-key-retrieve = true;
      no-comments = true;
      no-emit-version = true;
      default-key = cfg.gpg.defaultKey;
    };
  };
}
