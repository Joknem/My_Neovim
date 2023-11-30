local opt = { noremap = true, silent = true }
return {
	-------------auto comment-------------------
	{
		"preservim/nerdcommenter",
	},
	--------------bufferline--------------------
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
	--------------neodev-------------------
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({})
		end,
	},
	--------------surround "" {} and so on-------------------
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	---------------float window display definiton ...-----------------
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},
}
