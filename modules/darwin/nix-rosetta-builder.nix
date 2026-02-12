{
  config,
  ...
}:
let
  cfg = config.chad;
in
{
  nix-rosetta-builder = {
    cores = 4;
    diskSize = "32GiB";
    enable = !cfg.initialSetup;
    memory = "16GiB";
    onDemand = true;
    onDemandLingerMinutes = 180;
  };
}
