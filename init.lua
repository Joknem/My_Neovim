local set = vim.o
set.number = true
set.relativenumber = true
set.clipboard = "unnamed"
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
require("lazy").setup({
	{
		"RRethy/nvim-base16",
		lazy = true,
	},
	{
		keys = {
			{"<leader>p", ":Telescope find_files<CR>", desc = "find files"},
			{"<leader>P", ":Telescope live_grep<CR>", desc = "grep file"},
			{"<leader>rs", ":Telescope resume<CR>", desc = "resume"},
			{"<leader>q", ":Telescope oldfiles<CR>", desc = "oldfiles"},
		},
		"nvim-telescope/telescope.nvim", tag = '0.1.1',
		dependencies = {"nvim-lua/plenary.nvim"}
	}
})
vim.cmd.colorscheme("base16-tender")
