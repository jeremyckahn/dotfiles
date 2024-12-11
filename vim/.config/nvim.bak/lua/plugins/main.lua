return {
  {
    "folke/todo-comments.nvim",
    opts = {}
  },

  {
    "Asheq/close-buffers.vim",
    opts = {},
    config = function () end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  {
    "nvim-tree/nvim-web-devicons"
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "Telescope" },
    opts = {
    },
    keys = {
      {
        "<leader>/",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>p",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Find files",
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      }
    }
  },

  {
    'numToStr/Comment.nvim',
    opts = {
        -- add any options here
    }
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ position = "left", source = "filesystem", toggle = true })
        end,
        desc = "File tree"
      }
    },
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  }
}
