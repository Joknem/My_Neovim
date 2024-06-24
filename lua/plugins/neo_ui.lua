return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").load()
    end
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        git = {
          enable = false,
        },
      })
    end,
    keys = {
      { "<leader>t", ":NvimTreeToggle<CR>", desc = "Toggle Nvimtree state" },
    },
  },
  -- lualine --
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_c = {
            {
              "filename",
              path = 2,
            },
          },
        },
      })
    end,
    opts = {
      theme = "onedark",
    },
  },
  -- rainbow bracket --
  {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = true,
    event = 'BufRead',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterBlue',
          'RainbowDelimiterYellow',
          'RainbowDelimiterCyan',
          'RainbowDelimiterViolet',
          'RainbowDelimiterRed',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
        },
      }
    end
  },
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
      require("dashboard").setup({
        config = {
          header = {
            "          ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣙⣆⠀⠈⢳⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
            "    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⠶⠟⠛⠉⠁⠉⠛⠃⠀⠈⣿⠻⠷⠶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡄⠀⠀⠀⠀⠀⠈⠙⢿⣦⣄⣀⣤⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠾⠋⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣇⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⡉⢹⣿⣿⣿⣷⣶⣶⣤⠀⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡾⠋⠀⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⠀⠀⠀⠀⠀⠀⠀⠘⣿⣧⠀⢩⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⠀⠀⠀⠀⠀⠀⠀⠀⣴⠏⠀⠀⢸⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣧⠀⠀⠀⠀⠀⠀⢀⠀⠘⣿⣷⡀⢉⣿⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⠀⠀⠀⠀⠀⠀⣠⣾⠃⠀⠀⠀⣿⠃⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⣿⠀⠀⠀⢹⣇⠀⠀⠀⠀⠀⠘⣇⠀⠘⢿⣷⡉⠉⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⠀⠀⣀⣠⣴⣾⡿⠁⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⢰⡇⠀⠀⠸⣇⠀⠀⠀⢻⡄⠀⠀⠀⠀⠀⢻⡀⠀⠈⠻⣿⣮⡉⢹⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⢰⣿⣿⣿⣿⣿⠁⠀⢀⠀⠁⠀⢻⡆⠀⠀⠀⠀⠀⠀⢸⣧⠀⠀⠀⢻⡄⠀⠀⠀⢿⡀⠀⠀⠀⠀⠸⡇⠀⠀⠀⠘⡿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⠘⣿⣿⣿⣿⠇⠀⠀⣾⠀⠀⠀⢸⣧⠀⠀⠀⠀⠀⠀⠈⣿⣦⠀⠀⠈⢿⣄⠀⠀⠈⢷⡀⠀⠀⠀⠀⣷⠀⠀⠀⠀⢷⡀⠙⢿⣷⡀⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⠀⢻⣿⣿⡏⠀⢠⡀⢻⠀⠀⠀⢸⣿⣦⡀⠀⠀⠀⠀⠀⢿⡉⢷⡄⠀⠘⢿⣦⡀⠀⠈⢷⡀⠀⠀⠀⢻⠀⠀⠀⠀⠈⣧⠀⠈⢻⣷⡀⠀⠀⠀⠀⠀⠀     ",
            "    ⠀⠘⣿⡿⠀⠀⣸⠀⣸⡇⠀⠀⢸⡇⠈⢷⣄⡀⠀⠀⠀⢺⣇⠀⠙⢦⣄⠈⢷⡹⢦⡀⠈⣷⠀⠀⠀⢸⡇⠀⠀⠀⠀⠸⣇⠀⠀⠹⣷⡀⠀⠀⠀⠀⠀     ",
            "    ⠀⠀⣸⡇⠀⠀⡯⢠⣿⢿⡄⠀⢸⡇⠀⠀⠈⠛⠶⣦⣄⣀⣹⣿⡓⠳⠎⠛⠲⠿⢦⣽⣶⣼⣇⠀⠀⢸⡇⠀⠀⠀⠀⠀⢻⡄⠀⠀⢻⣧⠀⠀⠀⠀⠀     ",
            "    ⠀⢠⣿⠀⠀⠀⡇⣼⠏⠀⠻⣆⢘⣧⣴⠖⠋⠀⠀⠀⠀⠉⠁⠉⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡁⠀⢸⡇⠀⠀⠀⠀⠀⠘⣷⠀⠀⠈⣿⣇⠀⠀⠀⠀     ",
            "    ⠀⣼⡟⠀⠀⠀⣿⡟⠀⠀⠀⠙⠳⠥⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣼⡇⠀⢸⡇⠀⠀⠀⠀⠀⠀⢹⡇⠀⠀⡟⢿⣆⠀⠀⠀     ",
            "    ⢀⣿⡇⠀⠀⠀⣿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡤⢶⣾⣿⣿⣏⡹⠿⣇⠀⢸⡇⠀⠀⠀⠀⠀⠀⠘⣧⠀⠀⣧⠸⣿⡀⠀⠀     ",
            "    ⢸⣿⢣⠀⠀⠀⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣶⣯⠵⠶⠛⠉⠁⠀⠀⠀⠀⢿⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⢻⠀⠀⣿⠀⣿⣧⠀⠀     ",
            "    ⣸⡏⢹⠀⠀⠀⢿⡇⠀⠀⠀⣠⣤⣶⣾⣿⣻⣿⡿⠖⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⢀⠀⣀⠀⢸⡀⢸⠀⠀⠀⠀⠀⠀⠀⠀⢸⡆⠀⡿⢰⡏⣿⡀⠀     ",
            "    ⣿⡇⢸⡄⠀⠀⢸⣿⢀⣴⣟⣡⡽⠟⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡆⠸⣗⠻⠗⠻⠇⢸⡇⣸⠁⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⡇⢸⠇⢸⣧⠀     ",
            "    ⣿⡅⠘⣇⠀⠀⠀⣿⡘⠛⠉⠁⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⢈⡇⣿⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⢠⣃⡿⠀⠀⣿⠀     ",
            "    ⣿⢷⡀⢹⡄⠀⠀⢹⡇⠀⠀⣸⡆⠶⠄⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⡶⠃⠀⠀⠀⠀⠀⢸⣧⡇⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠘⣼⠃⠀⠀⢻⡄     ",
            "    ⣿⠈⣧⠈⢷⠀⠀⠈⣿⠀⠀⠈⠀⠀⠀⠀⢀⠀⠀⢀⣀⣤⠴⠖⢚⣩⠽⠋⠀⠀⠀⠀⠀⠀⠀⠀⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀⣰⠏⠀⠀⠀⢼⡇     ",
            "    ⣿⠀⠘⣇⠘⣧⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠉⠛⠛⠷⠖⠒⠒⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⢁⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⡿⢰⠟⠀⠀⠀⠀⣿⡄     ",
            "    ⣿⡄⠀⠘⣦⠘⣇⠀⠈⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⠾⠋⢀⣽⡇⠀⠀⠀⠀⠀⠀⠀⠀⢨⡷⠋⠀⠀⠀⠀⠀⣿⠀     ",
            "    ⢸⣧⠀⠀⠘⢧⡘⢧⡀⠘⠻⠶⢤⣤⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⣀⣀⣠⣴⣾⠟⠋⢀⣠⠶⢻⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠃⠀⠀⠀⠀⠀⣰⡏⠀     ",
            "    ⠀⢿⡆⠀⠀⡈⢳⣄⠱⣄⠀⠀⠀⠀⠀⣽⠉⠉⢉⣉⠙⢿⣉⠉⠻⣿⡿⠋⢀⣠⠖⠋⠁⠀⣾⠁⠀⠀⠀⠀⠀⠀⠀⠀⢰⡟⠀⠀⠀⠀⠀⣠⡟⠀⠀     ",
            "    ⠀⠈⢿⡄⠐⣧⠀⠙⢦⡈⠀⠀⠀⠀⠀⢻⣆⠀⠀⠙⢦⣀⠉⠳⢤⣘⣧⠶⠋⠁⠀⠀⠀⣰⡿⠀⠀⠀⠀⠀⠀⠀⢀⣠⠿⠃⠀⠀⠀⢀⣴⠟⠁⠀⠀     ",
            "    ⠀⠀⠈⢿⣄⢿⣧⡀⠀⠛⢦⣄⠀⠀⠀⢸⣿⣷⣄⡀⠀⠉⠳⠶⣶⠞⠁⠀⠀⠀⢀⣠⣾⣿⠀⠀⠀⠀⠀⠀⣠⣴⡏⠁⠀⠀⢀⣠⡴⠟⠁⠀⠀⠀⠀     ",
            "    ⠀⠀⠀⠀⠻⣾⣿⣛⣦⣄⠀⠈⠛⠲⠦⣄⣿⡇⠈⠙⠛⠶⠶⢶⣿⠀⠀⠀⢀⣴⣿⣿⣿⣯⣀⣀⣤⣤⣶⣿⣿⣿⣿⡛⠛⠋⠉⠉⠀⠀⠀⠀⠀⠀⠀     ",
            "    ⠀⠀⠀⠀⠀⠘⣻⣷⣄⣙⡛⠶⠦⣤⣤⣄⣸⣷⡄⠀⠀⠀⢠⠏⣻⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀     ",
          },
        },
      })
    end,
  },
  {
    'kevinhwang91/nvim-hlslens',
    lazy = true,
    keys = { '/', '?' },
    config = function()
      require('hlslens').setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '' or '')
          elseif absRelIdx == 1 then
            indicator = sfw ~= (relIdx == 1) and '' or ''
          else
            indicator = ''
          end

          local lnum, col = unpack(posList[idx])
          if nearest then
            local cnt = #posList
            if indicator ~= '' then
              text = ('[%s %d/%d]'):format(indicator, idx, cnt)
            else
              text = ('[%d/%d]'):format(idx, cnt)
            end
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
          else
            text = ('[%s %d]'):format(indicator, idx)
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end
      })
    end
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    event = "VeryLazy",
    config = function()
      local notify = require("notify")
      notify.setup({
        -- "fade", "slide
        stages = "slide",
        on_open = nil,
        on_close = nil,
        timeout = 3000,
        fps = 1,
        render = "default",
        background_colour = "Normal",
        max_width = math.floor(vim.api.nvim_win_get_width(0) / 2),
        max_height = math.floor(vim.api.nvim_win_get_height(0) / 4),
        -- minimum_width = 50,                                                                                                      │
        -- ERROR > WARN > INFO > DEBUG > TRACE                                                                                      │
        level = "TRACE",
      })
      vim.notify = notify
    end,
  },
}
