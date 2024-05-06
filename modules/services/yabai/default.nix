{ config, ... }:
let cfg = config.chad;
in {
  config = {
    auto_balance = true;
    layout = "bsp";
  };
  inherit (cfg.manageWindows) enable;
}

