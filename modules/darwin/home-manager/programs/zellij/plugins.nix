{
  keys,
  ...
}:
let
  locations = {
    sessionManager = "zellij:session-manager";
  };
in
{
  ${keys.welcomeScreen} = {
    _props = {
      localtion = locations.sessionManager;
    };
    welcome_screen = false;
  };
}
