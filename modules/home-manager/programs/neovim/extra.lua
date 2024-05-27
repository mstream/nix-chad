-- luacheck: globals vim
-- luacheck: no unused

local log_level = 1

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("LoggingLevelInfo", {}),
	callback = function()
		vim.cmd('echom "logging at level ' .. log_level .. '"')
	end,
})

local function create_logger(name)
	local function format_message(message)
		return name .. ": " .. message
	end
	local function print_message(message)
		vim.cmd('echom "' .. format_message(message) .. '"')
	end
	local function noop() end

	return {
		debug = (log_level >= 4 and { print_message } or { noop })[1],
		error = (log_level >= 1 and { print_message } or { noop })[1],
		info = (log_level >= 3 and { print_message } or { noop })[1],
		warn = (log_level >= 2 and { print_message } or { noop })[1],
	}
end

local lsp_logger = create_logger("lsp")
local keymap_logger = create_logger("keymap")

local function disable_mapping(mode, lhs)
	vim.api.nvim_set_keymap(mode, lhs, "<NOP>", { noremap = true })
end

local function disable_arrow_keys(mode)
	disable_mapping(mode, "<Up>")
	disable_mapping(mode, "<Down>")
	disable_mapping(mode, "<Right>")
	disable_mapping(mode, "<Left>")
end

local function on_server_capability(attach_event, capability_callbacks)
	local capabilities = {
		"codeActionProvider",
		"completionProvider",
		"declarationProvider",
		"definitionProvider",
		"documentFormattingProvider",
		"hoverProvider",
		"implementationProvider",
		"renameProvider",
	}
	local client = vim.lsp.get_client_by_id(attach_event.data.client_id)
	lsp_logger.info(
		"setting up buffer " .. attach_event.buf .. " based on " .. client.name .. " LSP server capabilities"
	)
	local file_type = vim.api.nvim_buf_get_option(attach_event.buf, "filetype")
	local sc = client.server_capabilities
	local log_prefix = "LSP server (" .. client.name .. ") for '" .. file_type .. "' buffer"
	for _, capability in ipairs(capabilities) do
		if sc[capability] then
			local callback = capability_callbacks[capability]
			if callback then
				lsp_logger.debug(log_prefix .. " supports '" .. capability .. "' capability")
				callback()
			else
				lsp_logger.warn(log_prefix .. " does not have callbag registered for '" .. capability .. "' capability")
			end
		else
			lsp_logger.warn(log_prefix .. " does not support '" .. capability .. "' capability")
		end
	end
end

local document_width = 72
local modes = { "c", "i", "l", "n", "o", "s", "t", "v", "x" }

for _, mode in ipairs(modes) do
	disable_arrow_keys(mode)
	disable_mapping(mode, "<C-n>")
	disable_mapping(mode, "<C-p>")
end

vim.api.nvim_set_keymap("c", "<c-u>", [[ wildmenumode() ? "<c-u>" : "<c-p>" ]], { noremap = true, expr = true })
vim.api.nvim_set_keymap("c", "<c-d>", [[ wildmenumode() ? "<c-d>" : "<c-n>" ]], { noremap = true, expr = true })

vim.g.dhall_format = 1
vim.g.mapleader = " "

vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.laststatus = 3
vim.o.mouse = "a"
vim.o.number = true
vim.o.numberwidth = 2
vim.o.ruler = false
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.undofile = true
vim.o.updatetime = 250

vim.opt.background = "dark"
vim.opt.colorcolumn = tostring(document_width + 1)
vim.opt.fillchars = { eob = " " }
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldnestmax = 4
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.shortmess:append("sI")
vim.opt.whichwrap:append("<>[]hl")

vim.wo.relativenumber = true

vim.filetype.add({
	extension = {
		purs = "purescript",
	},
})
