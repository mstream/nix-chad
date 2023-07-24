{ config, pkgs, ... }:
let
  cfg = config.my-meta;
in
{
  options.my-meta = {
    defaultGpgKey = pkgs.lib.mkOption {
      description = "The ID of a key that should be automatically used for GPG signing.";
      example = pkgs.lib.literalExpression "joe.smith@gmail.com";
      type = pkgs.lib.types.str;
    };
    email = pkgs.lib.mkOption {
      description = "Main user's email.";
      example = pkgs.lib.literalExpression "joe.smith@gmail.com";
      type = pkgs.lib.types.str;
    };
    realName = pkgs.lib.mkOption {
      description = "Main user's real name.";
      example = pkgs.lib.literalExpression "Joe Smith";
      type = pkgs.lib.types.str;
    };
    username = pkgs.lib.mkOption {
      description = "Main user's system name.";
      example = pkgs.lib.literalExpression "joe";
      type = pkgs.lib.types.str;
    };
  };
}
