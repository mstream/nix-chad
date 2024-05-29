{ lib, ... }:
with lib;
{
  options = {
    chad.gpg = {
      defaultKey = mkOption {
        type = types.nullOr types.str;
        default = null;
        example = "BE318F09150F6CB0724FFEC0319EE1D7FC029354";
        description = ''
          An ID of a key to be used for GPG signing by default.
          This is expected to be different for individuals.
          The key is not part of this repository and has to be provided
          manually.
        '';
      };
    };
  };
}
