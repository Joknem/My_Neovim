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
      { "<C-w>", ":bdelete %<CR>",           opt },
    },
    config = function()
      require("bufferline").setup()
    end,
  },
  {
    "folke/neodev.nvim",
    config = function()
      require('neodev').setup({
        lspconfig = true,
        override = function(_, library)
          library.enabled = true
          library.plugins = true
          library.types = true
        end,
      })
    end
  },
  {
    'windwp/nvim-autopairs',
    lazy = true,
    event = 'InsertEnter',
    opts = {}
  },
  {
    'nvimdev/guard.nvim',
    lazy = true,
    event = 'LspAttach',
    dependencies = {
      'nvimdev/guard-collection',
    },
    config = function()
      local ft = require('guard.filetype')
      ft('c', 'cpp'):fmt('clang-format')
      ft('python'):fmt('black')
      ft('lua'):fmt('lsp')
      require('guard').setup({
        fmt_on_save = false,
        lsp_as_default_formatter = true,
        vim.keymap.set({ 'n', 'v' }, '<leader>f', '<cmd>GuardFmt<CR>', {}),
      })
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
    }
  },
  {
    'nvimdev/flybuf.nvim',
    lazy = true,
    keys = '<leader>bf',
    config = function()
      require('flybuf').setup({
        hotkey = 'joknem',  -- hotkye
        border = 'rounded', -- border
        quit = 'q',         -- quit flybuf window
        mark = 'l',         -- mark as delet or cancel delete
        delete = 'd',       -- delete marked buffers or buffers which cursor in
      })
      vim.keymap.set('n', '<leader>bf', '<cmd>FlyBuf<CR>', {})
    end
  },
  {
    'folke/flash.nvim',
    lazy = true,
    opts = {},
    keys = {
      {
        '<leader><leader>f',
        mode = 'n',
        function()
          require('flash').jump()
        end,
        desc = 'Flash'
      },
    },
  },
}
