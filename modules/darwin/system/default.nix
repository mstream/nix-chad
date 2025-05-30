{
  config,
  ...
}:
let
  cfg = config.chad;
in
{
  config = {
    system = {
      keyboard = {
        enableKeyMapping = false;
        # Surprisingly, this public option is ignored as it can't be set by a user (based on the implementation)...
        # it sounds like something that may be corrected in further versions.
        # Temporarily, I am replacing it with a custom script in ZSH.
        #remapCapsLockToEscape = remapCapsLock;
        #userKeyMapping = if remapLeftArrow then [{
        #  HIDKeyboardModifierMappingSrc = 30064771152;
        #  HIDKeyboardModifierMappingDst = 30064771300;
        #}] else
        #  [ ];
      };
      primaryUser = cfg.user.name;
      stateVersion = 4;
    };
  };
  imports = [
    ./activation-scripts
    ./defaults.nix
  ];
}
