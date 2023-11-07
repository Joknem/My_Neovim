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
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 500,
		})
	end,
})
local opt = { noremap = true, silent = true }
vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>z", ":Files<CR>")
vim.keymap.set("n", "<leader>a", ":Ag<CR>")
vim.keymap.set("n", "<leader>-", "<C-W>s")
vim.keymap.set("n", "<leader>x", "<C-W>q")
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
vim.keymap.set("n", "<leader>p", ":Files<CR>")
vim.keymap.set("n", "<leader>b", ":Buffers<CR>")
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
--vim.keymap.set("n", "/", ":highlight Search guibg purple")
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
require("lazy").setup("plugins")

vim.cmd.colorscheme("kanagawa")
vim.opt.termguicolors = true
