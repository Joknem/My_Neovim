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
vim.api.nvim_create_autocmd({"TextYankPost"},{
	pattern = {"*"},
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})
--keybingdings
local opt = { noremap = true, silent = true }
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>-", "<C-W>s")
vim.keymap.set("n", "<leader>\\", "<C-W>v")
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-l>", "<C-W>l")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], {noremap = true, expr = true})
vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], {noremap = true, expr = true})
vim.keymap.set("n", "<leader>[", "<C-o>", opt)
vim.keymap.set("n", "<leader>]", "<C-i>", opt)
vim.keymap.set("n", "<leader>s", ":w<CR>", opt)
vim.keymap.set("n", "<leader>q", ":wq<CR>", opt)
vim.keymap.set("n", "<leader>gun", ":q!<CR>", opt)
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
			{"<leader>f", ":Telescope find_files<CR>", desc = "find files"},
			{"<leader>/", ":Telescope live_grep<CR>", desc = "grep file"},
			{"<leader>rs", ":Telescope resume<CR>", desc = "resume"},
			{"<leader>o", ":Telescope oldfiles<CR>", desc = "oldfiles"},
		},
		"nvim-telescope/telescope.nvim", tag = '0.1.1',
		dependencies = {"nvim-lua/plenary.nvim"}
	},
	--lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {"nvim-tree/nvim-web-devicons",},
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
		dependencies = {"nvim-tree/nvim-web-devicons",},
		config = function()
			require("nvim-tree").setup{}
		end,
		keys = {
		  	{"<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle Nvimtree state"}
		}
		},
	{
		"akinsho/bufferline.nvim",
		version = '*',
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		keys = {
		{"<S-h>", ":BufferLineCyclePrev<CR>", opt},
		{"<S-l>", ":BufferLineCycleNext<CR>", opt},
		{"<C-w>", ":bdelete %<CR>", opt},
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
--lsp configuration
require("mason").setup()
require("mason-lspconfig").setup()
require("lspconfig").lua_ls.setup {}

