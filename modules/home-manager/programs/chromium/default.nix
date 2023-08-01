{ pkgs, ... }: {
  enable = true;
  package = pkgs.runCommand "brave-0.0.0" { } "mkdir $out";
}
