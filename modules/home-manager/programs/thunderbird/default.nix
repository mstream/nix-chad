{ pkgs, username, ... }: {
  enable = false;
  package = pkgs.runCommand "thunderbird-0.0.0" { } "mkdir $out";
  profiles = { "${username}" = { isDefault = true; }; };
}
