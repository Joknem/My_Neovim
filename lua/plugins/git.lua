return {
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
}
