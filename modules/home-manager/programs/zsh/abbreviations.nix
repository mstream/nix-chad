{ pkgs, ... }:
with pkgs.lib;
let
  mergeAbbreviations =
    xs:
    let
      duplicates = builtins.attrNames (
        attrsets.filterAttrs (_: v: builtins.length v > 1) (attrsets.zipAttrs xs)
      );
    in
    (throwIf (
      builtins.length duplicates > 0
    ) "Duplicate abbreviations: ${builtins.toString duplicates}")
      (attrsets.mergeAttrsList xs);
  cd = {
    "\\-" = "cd -";
    "1" = "cd +1";
    "2" = "cd +2";
    "3" = "cd +3";
    "4" = "cd +4";
    "5" = "cd +5";
    "6" = "cd +6";
    "7" = "cd +7";
    "8" = "cd +8";
    "9" = "cd +9";
  };
  docker = {
    dkr = "docker";
    dkrb = "docker build";
    dkre = "docker exec -it";
    dkrps = "docker ps";
    dkrpsh = "docker push";
    dkrpl = "docker pull";
    dkrs = "docker stop";
    dkrt = "docker tag";
  };
  git = {
    gita = "git add";
    gitb = "git branch";
    gitch = "git checkout";
    gitcl = "git clone";
    gitcm = "git commit --all";
    gitd = "git diff";
    gitf = "git fetch --all --tags";
    gitg = "git grep";
    giti = "git init";
    gitl = "git log --decorate=full";
    gitm = "git merge";
    gitp = "git push origin";
    gitrb = "git rebase -r";
    gitrf = "git reflog";
    gitrm = "git rm";
    gitrmt = "git remote";
    gitrs = "git reset";
    gitst = "git status";
    gitstt = "git status";
    gitsts = "git stash";
    gitt = "git tag";
  };
  ls = {
    ls = "ls -a -l";
    lst = "ls -a -t -r";
  };
  nix = {
    nixb = "nix build .#";
    nixd = "nix develop --ignore-environment";
    nixf = "nix flake";
    nixrg = "nix registry";
    nixrn = "nix run nixpkgs#";
    nixrp = "nix repl";
    nixsh = "nix shell nixpkgs#";
    nixsr = "nix search";
    nixst = "nix store";
  };
  npm = {
    npmc = "npm ci";
    npmi = "npm install";
    npmr = "npm run";
    npms = "npm search";
    npmt = "npm test";
    npmu = "npm test";
  };
  sudo = {
    "_" = "sudo";
  };
in
{
  inherit mergeAbbreviations;
  defaultAbbreviations = mergeAbbreviations [
    cd
    docker
    git
    nix
    npm
    sudo
  ];
}
