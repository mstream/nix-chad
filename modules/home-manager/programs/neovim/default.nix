{ osConfig, pkgs, ... }:
with pkgs.lib;
let
  inherit (import ../../../../lib { inherit pkgs; }) lua;
  cfg = osConfig.chad;

  customKeyMappingsCode = kms: ''
    local custom_key_mappings = ${lua.renderAttrs kms} 
  '';

  extraConfigCode = builtins.readFile ./extra.lua;

  isNumberingRelative = cfg.editor.lineNumbering == "relative";
in
{
  programs.neovim = {
    coc.enable = false;
    defaultEditor = true;
    enable = true;
    extraLuaConfig = ''
      ${extraConfigCode}
      vim.opt.relativenumber = ${trivial.boolToString isNumberingRelative}
      ${customKeyMappingsCode cfg.editor.keyMappings}
    '';
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = import ./plugins { inherit pkgs; };
  };
}
