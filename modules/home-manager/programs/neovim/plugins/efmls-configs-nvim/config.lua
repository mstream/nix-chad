local function efm_lsp_config(context) -- luacheck: ignore
  local efmls_configs_utils = require("efmls-configs.utils")

  local formatters = {
    purescript = {
      formatCommand = "purs-tidy format",
      formatStdin = true,
    },
  }

  local linters = {
    github_action = {
      lintCommand = "actionlint",
      lintSource = efmls_configs_utils.sourceText("actionlint"),
      lintStdin = false,
      lintFormats = { "%f:%l:%c: %m" },
      prefix = "actionlint",
      requireMarker = true,
      rootMarkers = { "workflows/" },
    },
    hadolint = {
      lintCommand = "hadolint --no-color",
      lintSource = efmls_configs_utils.sourceText("hadolint"),
      lintStdin = false,
      lintFormats = { "%f:%l:%c %m" },
      prefix = "hadolint",
      rootMarkers = { ".hadolint.yaml" },
    },
  }

  local efmLanguagesConfig = {
    bash = {
      require("efmls-configs.formatters.shfmt"),
      require("efmls-configs.linters.shellcheck"),
    },
    dockerfile = {
      linters.hadolint,
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
      formatters.purescript,
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
      linters.github_action,
    },
  }

  return {
    cmd = {
      "efm-langserver",
      "-logfile",
      os.getenv("HOME") .. "/.local/state/nvim/efm-langserver.log",
      "-loglevel",
      tostring(context.log_level),
    },
    root_dir = context.find_git_ancestor,
    single_file_support = true,
    file_types = context.vim.tbl_keys(efmLanguagesConfig),
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
    },
    settings = {
      languages = efmLanguagesConfig,
      lintDebounde = "2s",
    },
  }
end
