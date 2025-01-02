{ modes, ... }:
{
  default_mode = modes.mapTo.key modes.members.normal;
  keybinds = {
    _props = {
      clear-defaults = false;
    };
  };
}
