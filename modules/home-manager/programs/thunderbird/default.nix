{ pkgs, username, ... }: {
  enable = true;
  package = pkgs.runCommand "thunderbird-0.0.0" { } "mkdir $out";
  profiles = { "${username}" = { isDefault = true; }; };
}
