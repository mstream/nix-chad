local function setup_efmls_configs_nvim(context) -- luacheck: ignore
	local efmls_configs_utils = require("efmls-configs.utils")

	local function lint_after_open(config)
		config.lintAfterOpen = true
		return config
	end

	local formatters = {
		autopep8 = require("efmls-configs.formatters.autopep8"),
		google_java_format = require("efmls-configs.formatters.google_java_format"),
		jq = require("efmls-configs.formatters.jq"),
		mdformat = require("efmls-configs.formatters.mdformat"),
		nixfmt = require("efmls-configs.formatters.nixfmt"),
		prettier = require("efmls-configs.formatters.prettier"),
		purs_tidy = {
			formatCommand = "purs-tidy format",
			formatStdin = true,
		},
		shfmt = require("efmls-configs.formatters.shfmt"),
		stylua = require("efmls-configs.formatters.stylua"),
	}

	local actionlint = require("efmls-configs.linters.actionlint")
	actionlint.rootMarkers = { "workflows" }

	local linters = {
		actionlint = actionlint,
		commitlint = {
			lintAfterOpen = true,
			lintCommand = "commitlint --strict",
			lintSource = efmls_configs_utils.sourceText("commitlint"),
			lintStdin = true,
			lintFormats = {
				"✖   %m [%s]",
				"⚠   %m [%s]",
			},
			prefix = "commitlint",
			requireMarker = true,
			rootMarkers = {
				".commitlintrc",
				".commitlintrc.json",
				".commitlintrc.yaml",
				".commitlintrc.yml",
				".commitlintrc.js",
				".commitlintrc.cjs",
				".commitlintrc.mjs",
				".commitlintrc.ts",
				".commitlintrc.cts",
				"commitlint.config.js",
				"commitlint.config.cjs",
				"commitlint.config.mjs",
				"commitlint.config.ts",
				"commitlint.config.cts",
			},
		},
		djlint = require("efmls-configs.linters.djlint"),
		flake8 = require("efmls-configs.linters.flake8"),
		hadolint = {
			lintCommand = "hadolint --no-color",
			lintSource = efmls_configs_utils.sourceText("hadolint"),
			lintStdin = false,
			lintFormats = { "%f:%l:%c %m" },
			prefix = "hadolint",
			rootMarkers = { ".hadolint.yaml" },
		},
		jq = require("efmls-configs.linters.jq"),
		luacheck = require("efmls-configs.linters.luacheck"),
		markdownlint = require("efmls-configs.linters.markdownlint"),
		shellcheck = require("efmls-configs.linters.shellcheck"),
		yamllint = require("efmls-configs.linters.yamllint"),
	}

	for _, conf in ipairs(linters) do
		lint_after_open(conf)
	end

	local efm_languages_config = {
		bash = {
			formatters.shfmt,
			linters.shellcheck,
		},
		gitcommit = {
			linters.commitlint,
		},
		dockerfile = {
			linters.hadolint,
		},
		html = {
			formatters.prettier,
			linters.djlint,
		},
		java = {
			formatters.google_java_format,
		},
		json = {
			formatters.jq,
			linters.jq,
		},
		lua = {
			formatters.stylua,
			linters.luacheck,
		},
		markdown = {
			formatters.mdformat,
			linters.markdownlint,
		},
		nix = {
			formatters.nixfmt,
		},
		purescript = {
			formatters.purs_tidy,
		},
		python = {
			formatters.autopep8,
			linters.flake8,
		},
		sh = {
			formatters.shfmt,
			linters.shellcheck,
		},
		yaml = {
			formatters.prettier,
			linters.yamllint,
			linters.actionlint,
		},
	}

	local config = {
		cmd = {
			"efm-langserver",
			"-logfile",
			os.getenv("HOME") .. "/.local/state/nvim/efm-langserver.log",
			"-loglevel",
			tostring(context.log_level),
		},
		root_dir = context.find_git_ancestor,
		single_file_support = true,
		file_types = context.vim.tbl_keys(efm_languages_config),
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
		},
		settings = {
			languages = efm_languages_config,
			lintDebounce = "1s",
		},
	}

	local function does_efms_format_file_type(conf, file_type) -- luacheck: ignore
		for _, handler in ipairs(conf.settings.languages[file_type]) do
			if handler.lintCommand then
				return true
			end
		end
		return false
	end

	local function does_efms_lint_file_type(conf, file_type) -- luacheck: ignore
		for _, handler in ipairs(conf.settings.languages[file_type]) do
			if handler.formatCommand then
				return true
			end
		end
		return false
	end

	return {
		config = config,
		does_efms_format_file_type = does_efms_format_file_type,
		does_efms_lint_file_type = does_efms_lint_file_type,
	}
end
