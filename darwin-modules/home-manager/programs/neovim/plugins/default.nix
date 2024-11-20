{ pkgs, ... }:
[
  (import ./which-key-nvim { inherit pkgs; })
  (import ./auto-hlsearch-nvim { inherit pkgs; })
  (import ./bufferline-nvim { inherit pkgs; })
  (import ./vim-airline { inherit pkgs; })
  (import ./vim-airline-themes { inherit pkgs; })
  (import ./gruvbox-nvim { inherit pkgs; })
  (import ./plenary-nvim { inherit pkgs; })
  (import ./telescope-nvim { inherit pkgs; })
  (import ./telescope-fzf-native-nvim { inherit pkgs; })
  (import ./efmls-configs-nvim { inherit pkgs; })
  (import ./cmp-nvim-lsp { inherit pkgs; })
  (import ./lsp-format-nvim { inherit pkgs; })
  (import ./nvim-lspconfig { inherit pkgs; })
  (import ./luasnip { inherit pkgs; })
  (import ./cmp-cmdline { inherit pkgs; })
  (import ./cmp-nvim-lsp-document-symbol { inherit pkgs; })
  (import ./cmp-omni { inherit pkgs; })
  (import ./cmp-path { inherit pkgs; })
  (import ./nvim-cmp { inherit pkgs; })
  (import ./nvim-navic { inherit pkgs; })
  (import ./nvim-treesitter { inherit pkgs; })
  (import ./nvim-web-devicons { inherit pkgs; })
  (import ./trouble-nvim { inherit pkgs; })
  (import ./nerdtree { inherit pkgs; })
  (import ./vim-nerdtree-syntax-highlight { inherit pkgs; })
  (import ./nerdtree-git-plugin { inherit pkgs; })
  # dummy plugin hack to make possible adding some config lines at the end 
  {
    config = ''
      -- initialize

      local context = {
        keymap_logger = keymap_logger,
        vim = vim,
      } 

      local key_utils = setup_which_key_nvim(context) 

      context.setup_efmls_configs_nvim = setup_efmls_configs_nvim
      context.log_level = log_level
      context.luasnip = luasnip
      context.on_server_capability = on_server_capability
      context.register_debug_mapping = key_utils.register_debug_mapping
      context.register_directory_tree_mapping = key_utils.register_directory_tree_mapping
      context.register_find_mapping = key_utils.register_find_mapping
      context.register_go_to_mapping = key_utils.register_go_to_mapping
      context.register_refactor_mapping = key_utils.register_refactor_mapping
      context.register_top_level_mapping = key_utils.register_top_level_mapping

      setup_auto_hlsearch_nvim(context)
      setup_bufferline_nvim(context)
      setup_gruvbox_nvim(context)
      setup_telescope_nvim(context)
      setup_telescope_fzf_native_nvim(context)
      setup_lsp_format_nvim(context)
      setup_nvim_lspconfig(context)
      setup_nvim_cmp(context)
      setup_nvim_navic(context)
      setup_nvim_treesitter(context)
      setup_nvim_web_devicons(context)
      setup_trouble_nvim(context)
      setup_nerdtree(context)
      setup_nerdtree_git_plugin(context)
    '';
    plugin = pkgs.vimPlugins.nvim-lspconfig;
    type = "lua";
  }
]
