{
  chadLib,
  config,
  ...
}:
let
  cfg = config.chad;
  kms = cfg.editor.keyMappings;
  mapping = import ./mapping.nix { inherit chadLib kms; };
  snippetExpandLuaFunction =
    body:
    chadLib.lua.ast.functionDefinition {
      inherit body;
      arguments = [ "args" ];
    };

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

  requireLuaFunctionInvocation =
    moduleName:
    with chadLib.lua.ast;
    functionInvocation {
      function = identifier "require";
      parameters = [ (string moduleName) ];
    };
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
          __raw = ''
            cmp.mapping.preset.cmdline({
                ["<C-n>"] = { c = cmp.mapping.select_next_item() },
                ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
            })
          '';
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
      snippet.expand = chadLib.lua.render (
        snippetExpandLuaFunction (
          with chadLib.lua.ast;
          [
            (functionInvocation {
              function = recordDereference {
                key = identifier "lsp_expand";
                record = requireLuaFunctionInvocation "luasnip";
              };
              parameters = [
                (recordDereference {
                  key = identifier "body";
                  record = identifier "args";
                })
              ];
            })
          ]
        )
      );
      sorting = {
        comparators =
          let
            builtIn =
              name:
              chadLib.lua.ast.recordDereference {
                key = chadLib.lua.ast.identifier name;
                record = requireLuaFunctionInvocation "cmp.config.compare";
              };
          in
          chadLib.core.map chadLib.lua.render [
            (requireLuaFunctionInvocation "cmp_fuzzy_buffer.compare")
            (requireLuaFunctionInvocation "cmp_fuzzy_path.compare")
            (builtIn "offset")
            (builtIn "exact")
            (builtIn "score")
            (builtIn "locality")
            (builtIn "recently_used")
            (builtIn "kind")
            (builtIn "length")
            (builtIn "order")
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
