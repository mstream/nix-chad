{
  config,
  ...
}:
let
  cfg = config.chad;
in
{
  security = {
    sudo.extraConfig = ''
      ${cfg.user.name} ALL=(ALL) ALL
    '';
  };
}
