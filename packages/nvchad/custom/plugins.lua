return {
	{ "preservim/vimux" },
	{
		"christoomey/vim-tmux-navigator",
		cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
		keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" },
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "mrjones2014/nvim-ts-rainbow" },
	{ "nvim-treesitter/nvim-treesitter-context" },

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
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					suggestion = {
						keymap = {
							accept = "<c-g>",
							accept_word = false,
							accept_line = false,
							next = "<c-j>",
							prev = "<c-k>",
							dismiss = "<c-f>",
						},
					},
				})
			end, 100)
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "VeryLazy",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-rhubarb" },
	{ "lewis6991/gitsigns.nvim" },
	{
		"Pocco81/TrueZen.nvim",
		cmd = { "TZNarrow", "TZFocus", "TZMinimalist", "TZAtaraxis" },
		config = true,
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
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		cmd = { "ToggleTerm" },
		version = "*",
		config = true,
	},
	{
		"tpope/vim-surround",
		dependencies = {
			"tpope/vim-repeat",
		},
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
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
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
				"clangd",
				"cssls",
				"dhall_lsp_server",
				"eslint",
				"hls",
				"html",
				"java_language_server",
				"jsonls",
				"lua_ls",
				"purescriptls",
				"pyright",
				"rnix",
				"rust_analyzer",
				"tailwindcss",
				"tsserver",
				"yamlls",
			}
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"mason.nvim",
		},
		opts = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			local code_actions = null_ls.builtins.code_actions
			local completion = null_ls.builtins.completion
			local lsp_formatting_group = vim.api.nvim_create_augroup("LspFormatting", {})
			return {
				debug = false,
				sources = {
					completion.spell,
					code_actions.gitsigns,
					formatting.stylua,
					formatting.prettier.with({
						extra_filetypes = { "svelte" },
					}),
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
					diagnostics.php,
					formatting.blade_formatter,
					formatting.black,
					formatting.shfmt,
					formatting.jq,
					formatting.rustfmt,
					formatting.clang_format,
					formatting.nixpkgs_fmt,
					formatting.taplo,
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
		"williamboman/mason.nvim",
		opts = function()
			return {
				ensure_installed = {
					"bash-language-server",
					"clangd",
					"css-lsp",
					"eslint-lsp",
					"html-lsp",
					"java-language-server",
					"json-lsp",
					"lua-language-server",
					"prettier",
					"prettierd",
					"pyright",
					"rnix-lsp",
					"rust-analyzer",
					"rustfmt",
					"shellcheck",
					"shfmt",
					"stylua",
					"tailwindcss-language-server",
					"taplo",
					"typescript-language-server",
					"yaml-language-server",
				},
			}
		end,
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
		"hrsh7th/nvim-cmp",
		opts = function()
			return vim.tbl_deep_extend("force", require("plugins.configs.cmp"), {
				sources = {
					{ name = "luasnip" },
					{ name = "copilot" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "path" },
				},
			})
		end,
	},
}
