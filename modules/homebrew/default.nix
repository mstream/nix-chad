{ extraCasks, manageHomebrew, ... }: {
  homebrew = {
    brews = [ ];
    casks = [
      "docker"
      "firefox"
      "google-chrome"
      "thunderbird"
    ] ++ extraCasks;
    enable = manageHomebrew;
    extraConfig = ''
      cask "firefox", args: { language: "en-GB" }
    '';
    global = {
      brewfile = true;
      lockfiles = false;
    };
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
      upgrade = false;
    };
  };
}
