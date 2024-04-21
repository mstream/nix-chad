{ pkgs, ... }:
[ ]
++ (pkgs.callPackage ./plugins/gruvbox-nvim/dependencies.nix { })
++ (pkgs.callPackage ./plugins/plenary-nvim/dependencies.nix { })
++ (pkgs.callPackage ./plugins/telescope-nvim/dependencies.nix { })
++ (pkgs.callPackage ./plugins/telescope-fzf-native-nvim/dependencies.nix { })
++ (pkgs.callPackage ./plugins/efmls-configs-nvim/dependencies.nix { })
++ (pkgs.callPackage ./plugins/cmp-nvim-lsp/dependencies.nix { })
++ (pkgs.callPackage ./plugins/nvim-lspconfig/dependencies.nix { })
++ (pkgs.callPackage ./plugins/luasnip/dependencies.nix { })
++ (pkgs.callPackage ./plugins/nvim-cmp/dependencies.nix { })
++ (pkgs.callPackage ./plugins/nvim-web-devicons/dependencies.nix { }) 
	
