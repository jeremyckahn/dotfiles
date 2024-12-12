return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "ollama",
          },
          inline = {
            adapter = "ollama",
          },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              env = {
                url = os.getenv("OLLAMA_URL"),
              },
              headers = {
                ["Content-Type"] = "application/json",
              },
              parameters = {
                sync = true,
              },
              num_ctx = {
                default = 32768,
              },
            })
          end,
        },
      })
    end,
    keys = {
      {
        "<C-a>",
        "<cmd>CodeCompanionActions<cr>",
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "<C-a>",
        "<cmd>CodeCompanionActions<cr>",
        mode = "v",
        noremap = true,
        silent = true,
      },
      {
        "<LocalLeader>a",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "<LocalLeader>a",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = "v",
        noremap = true,
        silent = true,
      },
      {
        "ga",
        "<cmd>CodeCompanionChat Add<cr>",
        mode = "v",
        noremap = true,
        silent = true,
      },
    },
  },
}
