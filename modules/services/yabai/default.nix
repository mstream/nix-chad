{ manageWindows, ... }: {
  config = {
    auto_balance = true;
    layout = "bsp";
  };
  enable = manageWindows;
}

