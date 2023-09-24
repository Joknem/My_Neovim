local set = vim.o
set.number = true
set.relativenumber = true
set.clipboard = "unnamed"
set.cursorline = true
set.autoindent = true
set.smartindent = true
set.shiftwidth = 4
set.softtabstop = 4
set.tabstop = 4
set.smartcase = true
set.showcmd = true
--clipboard highlight for 0.3s
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
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
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
vim.keymap.set("n", "<leader>[", "<C-o>", opt)
vim.keymap.set("n", "<leader>]", "<C-i>", opt)
vim.keymap.set("n", "<leader>s", ":w<CR>", opt)
vim.keymap.set("n", "<leader>qq", ":wq<CR>", opt)
vim.keymap.set("n", "<leader>gun", ":q!<CR>", opt)
vim.keymap.set("n", "<C-z>", ":u<CR>", opt)
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", opt)
--vim.keymap.set("n", "<leader>m")
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
	--telescope to find something
	{
		keys = {
			{ "<leader>fs", ":Telescope find_files<CR>", desc = "find files" },
			{ "<leader>/",  ":Telescope live_grep<CR>",  desc = "grep file" },
			{ "<leader>rs", ":Telescope resume<CR>",     desc = "resume" },
			{ "<leader>of", ":Telescope oldfiles<CR>",   desc = "oldfiles" },
		},
		"nvim-telescope/telescope.nvim",
		tag = '0.1.1',
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	--lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", },
		config = function()
			require("lualine").setup()
		end,
		opts = {
			theme = "monokai-pro",
		}
	},
	--nvim-tree
	{
		"nvim-tree/nvim-tree.lua",
		version = '*',
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons", },
		config = function()
			require("nvim-tree").setup {}
		end,
		keys = {
			{ "<leader>t", ":NvimTreeToggle<CR>", desc = "Toggle Nvimtree state" }
		}
	},
	{
		"akinsho/bufferline.nvim",
		version = '*',
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
			{ "<S-h>", ":BufferLineCyclePrev<CR>", opt },
			{ "<S-l>", ":BufferLineCycleNext<CR>", opt },
			{ "<C-w>", ":bdelete %<CR>",           opt },
		},
		config = function()
			require("bufferline").setup()
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
		lazy = true
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
			"L3MON4D3/LuaSnip"
		}
	}
})
--my theme configuration
require("monokai-pro").setup({
	devicons = true,
	transparent_background = false,
	filter = "machine",
	styles = {
		comment = { italic = true },
		keyword = { italic = true }, -- any other keyword
		type = { italic = true },    -- (preferred) int, long, char, etc
		storageclass = { italic = true }, -- static, register, volatile, etc
		structure = { italic = true }, -- struct, union, enum, etc
		parameter = { italic = true }, -- parameter pass in function
		annotation = { italic = true },
		tag_attribute = { italic = true }, -- attribute of tag in reactjs
	},
})
vim.cmd.colorscheme("monokai-pro")
vim.opt.termguicolors = true
------lsp configuration
require("mason").setup {
	providers = {
		"mason.providers.client",
		"mason.providers.registry-api"
	}
}
require("mason-lspconfig").setup()
--lua lsp config
require("lspconfig").lua_ls.setup {}
require("lspconfig").pyright.setup {}
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

