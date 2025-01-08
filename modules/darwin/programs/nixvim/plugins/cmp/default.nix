{
  chadLib,
  config,
  nix-to-lua,
  ...
}:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
  mapping = import ./mapping.nix { inherit chadLib kms nix-to-lua; };
  snippetExpand =
    body:
    nix-to-lua.uglyLua (
      nix-to-lua.inline.types.function-unsafe.mk {
        inherit body;
        args = [ "args" ];
      }
    );

  # their order influences the menu order priority
  sourceNames = [
    "nvim_lsp"
    "nvim_lsp_document_symbol"
    "nvim_lsp_signature_help"
    "luasnip"
    "treesitter"
    "dictionary"
    "spell"
    "calc"
    "yanky"
    "conventionalcommits"
    "dap"
    "digraphs"
    "emoji"
    "greek"
    "latex_symbols"
    "npm"
    "nvim_lua"
    "cmp_pandoc"
    "pandoc_references"
    "vimtex"
    "vimwiki-tags"
    "zsh"
    "fuzzy_buffer"
    "fuzzy_path"
    "rg"
  ];
in
{
  programs.nixvim.plugins.cmp = {
    autoEnableSources = true;
    cmdline = {
      "/" = {
        mapping = {
          __raw = "cmp.mapping.preset.cmdline()";
        };
        sources = [
          {
            name = "buffer";
          }
        ];
      };
      ":" = {
        mapping = {
          __raw = "cmp.mapping.preset.cmdline()";
        };
        sources = [
          {
            name = "path";
          }
          {
            name = "cmdline";
            option = {
              ignore_cmds = [
                "Man"
                "!"
              ];
            };
          }
        ];
      };
    };
    enable = true;
    settings = {
      inherit mapping;
      completion = {
        completeopt = "'menu,menuone,noselect'";
        keyword_length = 1;
        keyword_pattern = "[[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]]";
      };
      experimental.ghost_text = false;
      formatting.fields = [
        "kind"
        "abbr"
        "menu"
      ];
      snippet.expand = snippetExpand "require('luasnip').lsp_expand(args.body)";
      sorting = {
        comparators = [
          "require('cmp_fuzzy_buffer.compare')"
          "require('cmp_fuzzy_path.compare')"
          "require('cmp.config.compare').offset"
          "require('cmp.config.compare').exact"
          "require('cmp.config.compare').score"
          "require('cmp.config.compare').recently_used"
          "require('cmp.config.compare').locality"
          "require('cmp.config.compare').kind"
          "require('cmp.config.compare').length"
          "require('cmp.config.compare').order"
        ];
        priority_weight = 3;
      };
      sources = builtins.map (name: {
        inherit name;
        keyword_length = 1;
      }) sourceNames;
      view = {
        docs.autoopen = true;
        entries = {
          name = "custom";
          selection_order = "top_down";
        };
      };
      window = {
        completion = {
          col_offset = -3;
          side_padding = 0;
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None";
        };
      };
    };
  };
}
