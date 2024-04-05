local lspconfig = require("lspconfig")

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
  elseif lsp == "yamlls" then
    disable_diagnostics(config)
    disable_formatting(config)
  end

  lspconfig[lsp].setup(config)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),

  callback = function(ev)
    local function opts(desc)
      return { buffer = ev.buf, desc = desc }
    end

    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
    vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts("Go to definition"))

    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts(""))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts(""))
    vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts(""))
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts(""))
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts(""))
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts(""))
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts(""))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts(""))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts(""))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts(""))
  end,
})
