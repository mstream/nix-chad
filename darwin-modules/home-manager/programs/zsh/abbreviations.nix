{ lib, ... }:
let
  mergeAbbreviations =
    xs:
    let
      duplicates = lib.core.attrNames (
        lib.attrsets.filterAttrs (_: v: lib.core.length v > 1) (
          lib.attrsets.zipAttrs xs
        )
      );
    in
    (lib.trivial.throwIf (
      lib.core.length duplicates > 0
    ) "Duplicate abbreviations: ${lib.core.toString duplicates}")
      (lib.attrsets.mergeAttrsList xs);
  aws = {
    aws = "aws --profile \"%\" %";
  };
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
    dkrb = "docker build -t \"%\" %";
    dkre = "docker exec -it %";
    dkrps = "docker ps";
    dkrpsh = "docker push %";
    dkrpl = "docker pull %";
    dkrs = "docker stop %";
    dkrt = "docker tag %";
  };
  git = {
    gita = "git add %";
    gitb = "git branch";
    gitch = "git checkout";
    gitchb = "git checkout -b %";
    gitcl = "git clone";
    gitcm = "git commit --all";
    gitd = "git diff";
    gitf = "git fetch --all --tags";
    gitg = "git grep %";
    giti = "git init";
    gitl = "git log --decorate=full";
    gitm = "git merge %";
    gitp = "git push origin %";
    gitrb = "git rebase -r %";
    gitrf = "git reflog";
    gitrm = "git rm";
    gitrmt = "git remote";
    gitrs = "git reset";
    gitstt = "git status";
    gitsts = "git stash";
    gitt = "git tag";
  };
  kubectl = {
    kbc = "kubectl --context \"%\" --namespace \"%\" %";
  };
  ls = {
    ls = "ls -a -l";
    lst = "ls -a -t -r";
  };
  nix = {
    nixb = "nix build .#";
    nixd = "nix develop --ignore-environment";
    nixf = "nix flake %";
    nixrg = "nix registry";
    nixrn = "nix run nixpkgs#%";
    nixrp = "nix repl";
    nixsh = "nix shell nixpkgs#";
    nixsr = "nix search %";
    nixst = "nix store %";
  };
  npm = {
    npmc = "npm ci";
    npmi = "npm install";
    npmr = "npm run %";
    npms = "npm search %";
    npmt = "npm test";
    npmu = "npm update";
  };
  rm = {
    rmf = "rm -rf %";
  };
  sudo = {
    "_" = "sudo";
  };
in
{
  inherit mergeAbbreviations;
  defaultAbbreviations = mergeAbbreviations [
    aws
    cd
    docker
    git
    kubectl
    ls
    nix
    npm
    rm
    sudo
  ];
}
