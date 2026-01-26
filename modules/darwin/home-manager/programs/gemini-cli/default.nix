{ chadLib, ... }:
let
  allowedCommandPrefixes = [
    "cat"
    "cd"
    "diff"
    "echo"
    "find"
    "git grep"
    "git log"
    "git status"
    "grep"
    "head"
    "ls"
    "nix develop"
    "printf"
    "sed"
    "tail"
  ];
  policyText = import ./policy.nix {
    inherit chadLib allowedCommandPrefixes;
  };
  context = {
    discoveryMaxDirs = 1000;
    fileFiltering = {
      disableFuzzySearch = false;
      enableRecursiveFileSearch = true;
      respectGeminiIgnore = true;
      respectGitIgnore = true;
    };
    fileName = [ "AGENTS.md" ];
  };
  general = {
    checkpointing.enabled = true;
    debugKeystrokeLogging = false;
    disableAutoUpdate = true;
    disableUpdateNag = true;
    enablePromptCompletion = true;
    preferredEditor = "vim";
    previewFeatures = true;
    retryFetchErrors = true;
    sessionRetention = {
      enabled = true;
      maxAge = "2w";
      maxCount = 5;
      minRetention = "1d";
    };
    vimMode = true;
  };
  model = {
    compressionThreshold = 0.5;
    maxSessionTurns = -1;
    skipNextSpeakerCheck = true;
  };
  security = {
    blockGitExtensions = true;
    disableYoloMode = true;
  };
  tools = {
    autoAccept = false;
    sandbox = true;
    shell = {
      enableInteractiveShell = true;
      pager = "bat";
      showColor = true;
    };
    useRipgrep = true;
  };
  ui = {
    accessibility = {
      disableLoadingPhrases = false;
      screenReader = false;
    };
    footer = {
      hideCWD = false;
      hideContextPercentage = false;
      hideSandboxStatus = false;
      hideModelInfo = false;
    };
    hideBanner = false;
    hideContextSummary = false;
    hideFooter = false;
    hideTips = true;
    hideWindowTitle = false;
    incrementalRendering = true;
    showCitations = true;
    showLineNumbers = true;
    showMemoryUsage = true;
    showModelInfoInChat = true;
    showStatusInTitle = false;
    theme = "Dracula";
    useAlternateBuffer = true;
    useFullWidth = true;
  };
in
{
  home.file = {
    ".gemini/policies/custom.toml" = {
      recursive = true;
      text = policyText;
    };
  };
  programs.gemini-cli = {
    enable = true;
    settings = {
      inherit
        context
        general
        model
        security
        tools
        ui
        ;
      ide.enabled = false;
      output.format = "text";
      privacy.usageStatisticsEnabled = false;
    };
  };
}
