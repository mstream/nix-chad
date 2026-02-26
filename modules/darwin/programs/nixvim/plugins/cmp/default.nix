{
  chadLib,
  config,
  pkgs,
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
    #"zsh"
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

  settings = {
    inherit mapping;
    completion = {
      completeopt = "'menu,menuone,noselect'";
      keyword_length = 1;
    };
    experimental.ghost_text = false;
    formatting.fields = [
      "kind"
      "abbr"
      "menu"
    ];
    matching = {
      disallow_fullfuzzy_matching = false;
      disallow_fuzzy_matching = false;
      disallow_partial_fuzzy_matching = false;
      disallow_partial_matching = false;
      disallow_prefix_unmatching = false;
    };
    performance = {
      async_budget = 2;
      confirm_resolve_timeout = 250;
      debounce = 60;
      fetching_timeout = 500;
      max_view_entries = 50;
      throttle = 30;
    };
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
          (builtIn "exact")
          (builtIn "kind")
          (builtIn "offset")
          (builtIn "score")
          (builtIn "locality")
          (builtIn "recently_used")
          (builtIn "sort_text")
          (builtIn "length")
          (builtIn "order")
          (requireLuaFunctionInvocation "cmp_fuzzy_buffer.compare")
          (requireLuaFunctionInvocation "cmp_fuzzy_path.compare")
        ];
      priority_weight = 5;
    };
    sources = chadLib.imap0 (index: name: {
      inherit name;
      groupIndex = if chadLib.strings.hasPrefix "fuzzy" name then 2 else 1;
      keyword_length =
        if chadLib.strings.hasPrefix "fuzzy" name then 3 else 1;
      priority = 100 * (chadLib.core.length sourceNames - index);
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
in
{
  environment.systemPackages = with pkgs; [
    fd
    ripgrep
  ];
  programs.nixvim.plugins.cmp = {
    inherit settings;
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
  };
}
