vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamed"
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showcmd = true
vim.opt.encoding = "UTF-8"
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.autochdir = true
--vim.opt.list = true
--vim.opt.listchars = "tab:>•,nbsp:+,trail:•,extends:⮕,precedes:⬅"
vim.opt.undofile = true
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 500,
		})
	end,
})
vim.api.nvim_create_autocmd("TermOpen", { pattern = "term://*", command = [[startinsert]] })
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line
		if line("'\"") > 1 and line("'\"") <= line("$") then
			vim.cmd("normal! g'\"")
		end
	end,
})
local opt = { noremap = true, silent = true }
vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })
vim.g.mapleader = " "
vim.keymap.set({'n','t'}, '<leader>mm', '<cmd>Lspsaga term_toggle<CR>')
vim.keymap.set("n", "<leader>z", ":Files<CR>")
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
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
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
