-- luacheck: globals custom_key_mappings

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

    local efmls_result = context.setup_efmls_configs_nvim({
        find_git_ancestor = lspconfig_util.find_git_ancestor,
        log_level = context.log_level,
        vim = context.vim,
    })

    for _, lsp in ipairs(servers) do
        local config = {
            capabilities = capabilities,
            on_attach = on_attach,
        }

        if lsp == "efm" then
            for k, v in pairs(efmls_result.config) do
                config[k] = v
            end
        elseif lsp == "html" then
            config.cmd = { "html-languageserver", "--stdio" }
        elseif lsp == "java_language_server" then
            config.cmd = { "java-language-server" }
        elseif lsp == "jsonls" then
            config.cmd = { "vscode-json-languageserver", "--stdio" }
        end

        if lsp ~= "efm" and config.file_types ~= nil then
            -- TODO: disable formatting/linting it at the level of file type not LSP config
            for _, file_type in ipairs(config.file_types) do
                if
                    efmls_result.does_efmls_format_file_type(file_type)
                then
                    disable_formatting(config)
                end
                if
                    efmls_result.does_efmls_lint_file_type(file_type)
                then
                    disable_diagnostics(config)
                end
            end
        end

        lspconfig[lsp].setup(config)
    end

    context.vim.api.nvim_create_autocmd("LspAttach", {
        group = context.vim.api.nvim_create_augroup(
            "UserLspConfig",
            {}
        ),

        callback = function(ev)
            local opts = { buffer = ev.buf, mode = "n" }

            local function on_completion_support()
                context.vim.bo[ev.buf].omnifunc =
                "v:lua.vim.lsp.omnifunc"
            end

            local function on_declaration_support()
                context.register_go_to_mapping(
                    custom_key_mappings.go_to.declaration.combination,
                    context.vim.lsp.buf.declaration,
                    custom_key_mappings.go_to.declaration.description,
                    opts
                )
            end

            local function on_definition_support()
                context.register_find_mapping(
                    custom_key_mappings.find.definitions.combination,
                    telescope_builtin.lsp_definitions,
                    custom_key_mappings.find.definitions.description,
                    opts
                )
                context.register_go_to_mapping(
                    custom_key_mappings.go_to.definition.combination,
                    context.vim.lsp.buf.definition,
                    custom_key_mappings.go_to.definition.description,
                    opts
                )
                context.vim.bo[ev.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
            end

            local function on_implementation_support()
                context.register_find_mapping(
                    custom_key_mappings.find.implementations.combination,
                    telescope_builtin.lsp_implementations,
                    custom_key_mappings.find.implementations.description,
                    opts
                )
                context.register_go_to_mapping(
                    custom_key_mappings.go_to.implementation.combination,
                    context.vim.lsp.buf.implementation,
                    custom_key_mappings.go_to.implementation.description,
                    opts
                )
            end

            local function on_rename_support()
                context.register_refactor_mapping(
                    custom_key_mappings.refactor.name.combination,
                    context.vim.lsp.buf.rename,
                    custom_key_mappings.refactor.name.description,
                    opts
                )
            end

            local function on_code_actions_support()
                context.register_refactor_mapping(
                    custom_key_mappings.refactor.action.combination,
                    context.vim.lsp.buf.code_action,
                    custom_key_mappings.refactor.action.description,
                    opts
                )
            end

            local function on_document_formatting_support()
                context.register_refactor_mapping(
                    custom_key_mappings.refactor.format.combination,
                    context.vim.lsp.buf.format,
                    custom_key_mappings.refactor.format.description,
                    opts
                )
            end

            local function on_hover_support()
                context.register_top_level_mapping(
                    custom_key_mappings.top_level.show_symbol_info
                    .combination,
                    context.vim.lsp.buf.hover,
                    custom_key_mappings.top_level.show_symbol_info
                    .description,
                    opts
                )
            end

            local capability_callbacks = {
                ["codeActionProvider"] = on_code_actions_support,
                ["completionProvider"] = on_completion_support,
                ["declarationProvider"] = on_declaration_support,
                ["definitionProvider"] = on_definition_support,
                ["documentFormattingProvider"] =
                on_document_formatting_support,
                ["hoverProvider"] = on_hover_support,
                ["implementationProvider"] = on_implementation_support,
                ["renameProvider"] = on_rename_support,
            }

            context.on_server_capability(ev, capability_callbacks)
        end,
    })
end
