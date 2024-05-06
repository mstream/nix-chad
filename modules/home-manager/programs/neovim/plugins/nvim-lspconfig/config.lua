-- luacheck: globals on_server_capability register_find_mapping register_go_to_mapping register_refactor_mapping register_top_level_mapping vim

local lspconfig = require("lspconfig")
local telescope_builtin = require("telescope.builtin")

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

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = require("lsp-format").on_attach

local efmLanguagesConfig = {
  bash = {
    require("efmls-configs.formatters.shfmt"),
    require("efmls-configs.linters.shellcheck"),
  },
  docker = {
    require("efmls-configs.linters.hadolint"),
  },
  html = {
    require("efmls-configs.formatters.prettier"),
    require("efmls-configs.linters.djlint"),
  },
  java = {
    require("efmls-configs.formatters.google_java_format"),
  },
  json = {
    require("efmls-configs.formatters.jq"),
    require("efmls-configs.linters.jq"),
  },
  lua = {
    require("efmls-configs.formatters.stylua"),
    require("efmls-configs.linters.luacheck"),
  },
  markdown = {
    require("efmls-configs.formatters.mdformat"),
    require("efmls-configs.linters.markdownlint"),
  },
  nix = {
    require("efmls-configs.formatters.nixfmt"),
  },
  purescript = {
    {
      formatCommand = "purs-tidy format",
      formatStdin = true,
    },
  },
  python = {
    require("efmls-configs.formatters.autopep8"),
    require("efmls-configs.linters.flake8"),
  },
  sh = {
    require("efmls-configs.formatters.shfmt"),
    require("efmls-configs.linters.shellcheck"),
  },
  yaml = {
    require("efmls-configs.formatters.prettier"),
    require("efmls-configs.linters.yamllint"),
  },
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
    config.cmd = {
      "efm-langserver",
      "-logfile",
      os.getenv("HOME") .. "/.local/state/nvim/efm-langserver.log",
      "-loglevel",
      "1",
    }
    config.init_options = { documentFormatting = true, documentRangeFormatting = true }
    config.settings = {
      rootMarkers = { ".git/" },
      languages = efmLanguagesConfig,
    }
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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),

  callback = function(ev)
    local opts = { buffer = ev.buf, mode = "n" }

    register_top_level_mapping("K", vim.lsp.buf.hover, "Display information about symbol under cursor", opts)

    local function on_completion_support()
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    local function on_declaration_support()
      register_go_to_mapping("d", vim.lsp.buf.declaration, "Declaration", opts)
    end

    local function on_definition_support()
      local what = "Definition"
      register_find_mapping("D", telescope_builtin.lsp_definitions, what, opts)
      register_go_to_mapping("D", vim.lsp.buf.definition, what, opts)
      vim.bo[ev.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    local function on_implementation_support()
      local what = "Implementation"
      register_find_mapping("i", telescope_builtin.lsp_definitions, what, opts)
      register_go_to_mapping("i", vim.lsp.buf.implementation, what, opts)
    end

    local function on_rename_support()
      register_refactor_mapping("n", vim.lsp.buf.rename, "Name", opts)
    end

    local function on_code_actions_support()
      register_refactor_mapping("a", vim.lsp.buf.rename, "Actions", opts)
    end

    local capability_callbacks = {
      ["completionProvider"] = on_completion_support,
      ["declarationProvider"] = on_declaration_support,
      ["definitionProvider"] = on_definition_support,
      ["implementationProvider"] = on_implementation_support,
      ["renameProvider"] = on_rename_support,
      ["codeActionProvider"] = on_code_actions_support,
    }

    on_server_capability(ev, capability_callbacks)
  end,
})
