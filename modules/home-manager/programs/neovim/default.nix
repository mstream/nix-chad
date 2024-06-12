{ osConfig, pkgs, ... }:
with pkgs.lib;
let
  inherit (import ../../../../lib { inherit pkgs; }) lua;
  cfg = osConfig.chad;

  customKeyMappingsCode = kms: ''
    local custom_key_mappings = ${lua.renderAttrs kms} 
  '';

  extraConfigCode = builtins.readFile ./extra.lua;
in
{
  programs.neovim = {
    coc.enable = false;
    defaultEditor = true;
    enable = true;
    extraLuaConfig = ''
      ${extraConfigCode}
      ${customKeyMappingsCode cfg.neovim.keyMappings}
    '';
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = import ./plugins { inherit pkgs; };
  };
}
