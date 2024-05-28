local lspconfig = require("lspconfig")
local lspconfig_util = require("lspconfig.util")
local telescope_builtin = require("telescope.builtin")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = require("lsp-format").on_attach

local function setup_nvim_lspconfig(context) -- luacheck: ignore
	local servers = {
		"bashls",
		"dhall_lsp_server",
		"efm",
		"html",
		"java_language_server",
		"jsonls",
		"lua_ls",
		"marksman",
		"nixd",
		"purescriptls",
		"jedi_language_server",
		"tsserver",
		"yamlls",
	}

	local function disable_diagnostics(config)
		config.handlers = {
			["textDocument/publishDiagnostics"] = function() end,
		}
	end

	local function disable_formatting(config)
		config.handlers = {
			["textDocument/formatting"] = function() end,
			["textDocument/rangeFormatting"] = function() end,
		}
	end

	for _, lsp in ipairs(servers) do
		local config = {
			capabilities = capabilities,
			on_attach = on_attach,
		}
		if lsp == "bashls" then
			disable_diagnostics(config)
			disable_formatting(config)
		elseif lsp == "efm" then
			local config_overrides = context.efm_lsp_config({
				find_git_ancestor = lspconfig_util.find_git_ancestor,
				log_level = context.log_level,
				vim = context.vim,
			})
			for k, v in pairs(config_overrides) do
				config[k] = v
			end
		elseif lsp == "html" then
			disable_diagnostics(config)
			disable_formatting(config)
			config.cmd = { "html-languageserver", "--stdio" }
		elseif lsp == "java_language_server" then
			disable_formatting(config)
			config.cmd = { "java-language-server" }
		elseif lsp == "jedi_language_server" then
			disable_diagnostics(config)
			disable_formatting(config)
		elseif lsp == "jsonls" then
			disable_diagnostics(config)
			disable_formatting(config)
			config.cmd = { "vscode-json-languageserver", "--stdio" }
		elseif lsp == "lua_ls" then
			disable_diagnostics(config)
			disable_formatting(config)
		elseif lsp == "yamlls" then
			disable_diagnostics(config)
			disable_formatting(config)
		end

		lspconfig[lsp].setup(config)
	end

	context.vim.api.nvim_create_autocmd("LspAttach", {
		group = context.vim.api.nvim_create_augroup("UserLspConfig", {}),

		callback = function(ev)
			local opts = { buffer = ev.buf, mode = "n" }

			local function on_completion_support()
				context.vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
			end

			local function on_declaration_support()
				context.register_go_to_mapping("d", context.vim.lsp.buf.declaration, "Declaration", opts)
			end

			local function on_definition_support()
				local what = "Definition"
				context.register_find_mapping("D", telescope_builtin.lsp_definitions, what, opts)
				context.register_go_to_mapping("D", context.vim.lsp.buf.definition, what, opts)
				context.vim.bo[ev.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
			end

			local function on_implementation_support()
				local what = "Implementation"
				context.register_find_mapping("i", telescope_builtin.lsp_definitions, what, opts)
				context.register_go_to_mapping("i", context.vim.lsp.buf.implementation, what, opts)
			end

			local function on_rename_support()
				context.register_refactor_mapping("n", context.vim.lsp.buf.rename, "Name", opts)
			end

			local function on_code_actions_support()
				context.register_refactor_mapping("a", context.vim.lsp.buf.rename, "Actions", opts)
			end

			local function on_document_formatting_support()
				context.register_refactor_mapping("f", context.vim.lsp.buf.format, "Format", opts)
			end

			local function on_hover_support()
				context.register_top_level_mapping(
					"K",
					context.vim.lsp.buf.hover,
					"Display information about symbol under cursor",
					opts
				)
			end

			local capability_callbacks = {
				["codeActionProvider"] = on_code_actions_support,
				["completionProvider"] = on_completion_support,
				["declarationProvider"] = on_declaration_support,
				["definitionProvider"] = on_definition_support,
				["documentFormattingProvider"] = on_document_formatting_support,
				["hoverProvider"] = on_hover_support,
				["implementationProvider"] = on_implementation_support,
				["renameProvider"] = on_rename_support,
			}

			context.on_server_capability(ev, capability_callbacks)
		end,
	})
end
