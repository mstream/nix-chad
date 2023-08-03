return {
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		cmd = { "ToggleTerm" },
		version = "*",
		config = true,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
		},
		keys = {
			"<C-h>",
			"<C-j>",
			"<C-k>",
			"<C-l>",
		},
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		cmd = { "Lspsaga" },
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	{
		"hashivim/vim-terraform",
		ft = "terraform",
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			return vim.tbl_deep_extend("force", require("plugins.configs.cmp"), {
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "path" },
				},
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		config = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		opts = function()
			local null_ls = require("null-ls")
			local code_actions = null_ls.builtins.code_actions
			local completion = null_ls.builtins.completion
			local diagnostics = null_ls.builtins.diagnostics
			local formatting = null_ls.builtins.formatting
			local lsp_formatting_group = vim.api.nvim_create_augroup("LspFormatting", {})
			return {
				debug = false,
				sources = {
					code_actions.eslint_d.with({
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
						},
					}),
					code_actions.gitsigns,
					code_actions.proselint,
					code_actions.shellcheck,
					code_actions.statix,
					completion.spell,
					completion.tags,
					diagnostics.actionlint,
					diagnostics.checkstyle,
					diagnostics.codespell,
					diagnostics.deadnix,
					diagnostics.editorconfig_checker,
					diagnostics.eslint_d.with({
						condition = function(utils)
							return utils.root_has_file(".eslintrc.js") or utils.root_has_file(".eslintrc.cjs")
						end,
						filetypes = {
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
						},
					}),
					diagnostics.hadolint,
					diagnostics.jsonlint,
					diagnostics.luacheck,
					diagnostics.markdownlint,
					diagnostics.mdl,
					diagnostics.proselint,
					diagnostics.shellcheck,
					diagnostics.statix,
					diagnostics.stylelint,
					diagnostics.terraform_validate,
					diagnostics.textlint,
					diagnostics.tfsec,
					diagnostics.tsc,
					diagnostics.typos,
					diagnostics.write_good,
					diagnostics.yamllint,
					formatting.black,
					formatting.beautysh,
					formatting.cbfmt,
					formatting.codespell,
					formatting.fixjson,
					formatting.google_java_format,
					formatting.jq,
					formatting.markdownlint,
					formatting.nixpkgs_fmt,
					formatting.prettier.with({
						extra_filetypes = { "svelte" },
					}),
					formatting.purs_tidy,
					formatting.shellharden,
					formatting.shfmt,
					formatting.stylelint,
					formatting.stylua,
					formatting.taplo,
					formatting.terraform_fmt,
					formatting.textlint,
					formatting.treefmt,
					formatting.trim_newlines,
					formatting.trim_whitespace,
					formatting.yamlfix,
				},
				on_attach = function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = lsp_formatting_group, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = lsp_formatting_group,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									bufnr = bufnr,
									filter = function(client)
										return client.name == "null-ls"
									end,
								})
							end,
						})
					end
				end,
			}
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	{
		"mrjones2014/nvim-ts-rainbow",
	},
	{
		"nathom/filetype.nvim",
		opts = function()
			return {
				overrides = {
					extensions = {
						mdx = "markdown",
					},
					function_complex = {
						[".*blade.php"] = function()
							vim.bo.filetype = "blade"
						end,
					},
				},
			}
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function(_, _)
			require("plugins.configs.lspconfig")
			local on_attach = require("plugins.configs.lspconfig").on_attach
			local capabilities = require("plugins.configs.lspconfig").capabilities
			local lspconfig = require("lspconfig")
			local servers = {
				"bashls",
				"dhall_lsp_server",
				"eslint",
				"lua_ls",
				"purescriptls",
				"pyright",
				"rnix",
				"tsserver",
				"yamlls",
			}
			vim.g.dhall_format = 1
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end
			-- TODO: broken
			-- lspconfig["java_language_server"].setup({
			-- 	capabilities = capabilities,
			-- 	cmd = { "java-language-server" },
			-- 	on_attach = on_attach,
			-- })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ignore_install = { "help" }
			return vim.tbl_deep_extend("force", require("plugins.configs.treesitter"), {
				ensure_installed = {
					"c",
					"cpp",
					"css",
					"go",
					"lua",
					"python",
					"rust",
					"typescript",
					"svelte",
					"html",
					"java",
					"help",
					"nix",
					"markdown",
					"markdown_inline",
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	{
		"Pocco81/TrueZen.nvim",
		cmd = { "TZNarrow", "TZFocus", "TZMinimalist", "TZAtaraxis" },
		config = true,
	},
	{
		"preservim/vimux",
	},
	{
		"purescript-contrib/purescript-vim",
		ft = "purescript",
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"tpope/vim-rhubarb",
	},
	{
		"tpope/vim-surround",
		dependencies = {
			"tpope/vim-repeat",
		},
	},
	{
		"vmchale/dhall-vim",
		ft = "dhall",
	},
}
