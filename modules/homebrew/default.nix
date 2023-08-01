{ manageHomebrew }: {
  homebrew = {
    brews = [ ];
    casks = [
      "brave-browser"
      "discord"
      "docker"
      "firefox"
      "google-chrome"
      "inkscape"
      "intellij-idea"
      "microsoft-teams"
      "slack"
      "steam"
      "thunderbird"
      "vlc"
    ];
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
