local set = vim.o
set.number = true
set.relativenumber = true
set.clipboard = "unnamed"
set.cursorline = true
set.autoindent = true
set.smartindent = true
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 2
set.smartcase = true
set.showcmd = true
set.encoding = "UTF-8"
vim.opt.signcolumn = "yes"
--vim.opts.s
--clipboard highlight for 0.5s
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 500,
		})
	end,
})
--keybingdings
local opt = { noremap = true, silent = true }
vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>-", "<C-W>s")
vim.keymap.set("n", "<leader>\\", "<C-W>v")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>h", "<C-W>h")
vim.keymap.set("n", "<leader>l", "<C-W>l")
vim.keymap.set("n", "<leader>k", "<C-W>k")
vim.keymap.set("n", "<leader>j", "<C-W>j")
vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
vim.keymap.set("n", "<leader>[", "<C-o>", opt)
vim.keymap.set("n", "<leader>]", "<C-i>", opt)
vim.keymap.set("n", "<leader>s", ":w<CR>", opt)
vim.keymap.set("n", "<leader>qq", ":wq<CR>", opt)
vim.keymap.set("n", "<leader>gun", ":q!<CR>", opt)
vim.keymap.set("n", "<C-z>", ":u<CR>", opt)
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", opt)
vim.keymap.set("n", "J", "5j", opt)
vim.keymap.set("n", "H", "5h", opt)
vim.keymap.set("n", "L", "5l", opt)
vim.keymap.set("n", "K", "5k", opt)
--nnoremap <silent><leader>ls <cmd>lua vim.lsp.buf.document_symbol()<CR>
--nnoremap <silent><leader>ll <cmd>lua vim.lsp.buf.references()<CR>
--nnoremap <silent><leader>lg <cmd>lua vim.lsp.buf.definition()<CR>
--nnoremap <silent><leader>la <cmd>lua vim.lsp.buf.code_action()<CR>
--nnoremap <silent><leader>l; <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
--nnoremap <silent><leader>l, <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
--lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- add your own plugins
require("lazy").setup({
	--my scheme
	{
		"loctvl842/monokai-pro.nvim",
		lazy = false,
	},
	{
		"folke/neodev.nvim",
	},
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	--git
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		cmd = "Git",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
	},
	--telescope to find something
	{
		keys = {
			{ "<leader>fs", ":Telescope find_files<CR>", desc = "find files" },
			{ "<leader>/", ":Telescope live_grep<CR>", desc = "grep file" },
			{ "<leader>rs", ":Telescope resume<CR>", desc = "resume" },
			{ "<leader>of", ":Telescope oldfiles<CR>", desc = "oldfiles" },
		},
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	--lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup()
		end,
		opts = {
			theme = "monokai-pro",
		},
	},
	--	nvim - tree
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({})
		end,
		keys = {
			{ "<leader>t", ":NvimTreeToggle<CR>", desc = "Toggle Nvimtree state" },
		},
	},
	--nerdtree
	--	{
	--		"preservim/nerdtree",
	--		event = "VeryLazy",
	--		keys = {
	--			{ "<leader>t", ":NERDTreeToggle<CR>", desc = "toggle nerdtree" },
	--		},
	--		cmd = { "NERDTreeToggle", "NERDTree", "NERDTreeFind" },
	--		config = function()
	--			vim.cmd([[
	--			let NERDTreeShowNumbers = 1
	--			autocmd FileType nerdtree setlocal relativenumber
	--			]])
	--		end,
	--		dependencies = {
	--			"Xuyuanp/nerdtree-git-plugin",
	--			"ryanoasis/vim-devicons",
	--		},
	--	},
	--session save
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		config = function()
			require("persistence").setup()
		end,
	},
	--bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{ "<S-h>", ":BufferLineCyclePrev<CR>", opt },
			{ "<S-l>", ":BufferLineCycleNext<CR>", opt },
			{ "<C-w>", ":bdelete %<CR>", opt },
		},
		config = function()
			require("bufferline").setup()
		end,
	},
	{
		"ojroques/nvim-lspfuzzy",
		dependencies = { { "junegunn/fzf" }, { "junegunn/fzf.vim" } },
		config = function()
			require("lspfuzzy").setup({
				methods = "all", -- either 'all' or a list of LSP methods (see below)
				jump_one = true, -- jump immediately if there is only one location
				save_last = false, -- save last location results for the :LspFuzzyLast command
				callback = nil, -- callback called after jumping to a location
				fzf_preview = { -- arguments to the FZF '--preview-window' option
					"right:+{2}-/2",
				}, -- preview on the right and centered on entry
				fzf_action = { -- FZF actions
					["ctrl-t"] = "tab split", -- go to location in a new tab
					["ctrl-v"] = "vsplit", -- go to location in a vertical split
					["ctrl-x"] = "split", -- go to location in a horizontal split
				},
				fzf_modifier = ":~:.", -- format FZF entries, see |filename-modifiers|
				fzf_trim = true,
			})
		end,
	},
	--lsp and auto cmp
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black,
				},
				--set save checking formatting
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		build = ":MasonUpdate",
		dependencies = "williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		lazy = true,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "VeryLazy",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	--nvim treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensured_installed = { "lua", "vim", "c", "make", "markdown", "python", "verilog", "json" },
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						node_incremental = "v",
						node_decremental = "<BS>",
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = {
						enable = true,

						-- Automatically jump forward to textobj, similar to targets.vim
						lookahead = true,

						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						-- If you set this to `true` (default is `false`) then any textobject is
						-- extended to include preceding or succeeding whitespace. Succeeding
						-- whitespace has priority in order to act similarly to eg the built-in
						-- `ap`.
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * selection_mode: eg 'v'
						-- and should return true of false
						include_surrounding_whitespace = true,
					},
				},
			})
		end,
	},
})
--my theme configuration
require("monokai-pro").setup({
	devicons = true,
	transparent_background = false,
	filter = "machine",
	styles = {
		comment = { italic = true },
		keyword = { italic = true }, -- any other keyword
		type = { italic = true }, -- (preferred) int, long, char, etc
		storageclass = { italic = true }, -- static, register, volatile, etc
		structure = { italic = true }, -- struct, union, enum, etc
		parameter = { italic = true }, -- parameter pass in function
		annotation = { italic = true },
		tag_attribute = { italic = true }, -- attribute of tag in reactjs
	},
})
vim.cmd.colorscheme("monokai-pro")
vim.opt.termguicolors = true
local db = require("dashboard")
db.custom_header = {
	"   ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣴⣶⣶⣶⣶⣶⠶⣶⣤⣤⣀⠀⠀⠀⠀⠀⠀ ",
	" ⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⠁⠀⢀⠈⢿⢀⣀⠀⠹⣿⣿⣿⣦⣄⠀⠀⠀ ",
	" ⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⠿⠀⠀⣟⡇⢘⣾⣽⠀⠀⡏⠉⠙⢛⣿⣷⡖⠀ ",
	" ⠀⠀⠀⠀⠀⣾⣿⣿⡿⠿⠷⠶⠤⠙⠒⠀⠒⢻⣿⣿⡷⠋⠀⠴⠞⠋⠁⢙⣿⣄ ",
	" ⠀⠀⠀⠀⢸⣿⣿⣯⣤⣤⣤⣤⣤⡄⠀⠀⠀⠀⠉⢹⡄⠀⠀⠀⠛⠛⠋⠉⠹⡇ ",
	" ⠀⠀⠀⠀⢸⣿⣿⠀⠀⠀⣀⣠⣤⣤⣤⣤⣤⣤⣤⣼⣇⣀⣀⣀⣛⣛⣒⣲⢾⡷ ",
	" ⢀⠤⠒⠒⢼⣿⣿⠶⠞⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⣼⠃ ",
	" ⢮⠀⠀⠀⠀⣿⣿⣆⠀⠀⠻⣿⡿⠛⠉⠉⠁⠀⠉⠉⠛⠿⣿⣿⠟⠁⠀⣼⠃⠀ ",
	" ⠈⠓⠶⣶⣾⣿⣿⣿⣧⡀⠀⠈⠒⢤⣀⣀⡀⠀⠀⣀⣀⡠⠚⠁⠀⢀⡼⠃⠀⠀ ",
	" ⠀⠀⠀⠈⢿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣤⣭⣭⣭⣭⣭⣥⣤⣤⣤⣴⣟⠁    ",
}
-- vim doc
require("neodev").setup({
	library = {
		enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
		-- these settings will be used for your Neovim config directory
		runtime = true, -- runtime path
		types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
		plugins = true, -- installed opt or start plugins in packpath
		-- you can also specify the list of plugins to make available as a workspace library
		-- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
	},
	setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
	-- for your Neovim config directory, the config.library settings will be used as is
	-- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
	-- for any other directory, config.library.enabled will be set to false
	override = function(root_dir, options) end,
	-- With lspconfig, Neodev will automatically setup your lua-language-server
	-- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
	-- in your lsp start options
	lspconfig = true,
	-- much faster, but needs a recent built of lua-language-server
	-- needs lua-language-server >= 3.6.0
	pathStrict = true,
})
------lsp configuration
require("mason").setup({
	PATH = "prepend",
	providers = {
		"mason.providers.client",
		"mason.providers.registry-api",
	},
})
require("mason-lspconfig").setup()
--lua lsp config
require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	settings = {
		workspace = {
			checkThirdParty = false,
		},
	},
})
require("lspconfig").pyright.setup({
	capabilities = capabilities,
})
require("lspconfig").clangd.setup({
	capabilities = capabilities,
})
require("lspconfig").ltex.setup({
	capabilities = capabilities,
})
require("lspconfig").svlangserver.setup({
	capabilities = capabilities,
})
--require("lspconfig").docdoc.setup({})
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "D", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
--cmp configuration
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			--vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-c>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "lua snip" }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
		{ name = "markdown" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
--cursor at last change position
local args = vim.api.nvim_get_vvar("argv")
if #args > 2 then
else
	require("persistence").load({ last = true })
end
