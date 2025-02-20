return {
  {
    "tpope/vim-fugitive",
  },

  {
    "tpope/vim-rhubarb",
  },

  {
    "sindrets/diffview.nvim",
    branch = "main",
  },

  {
    "pechorin/any-jump.vim",
  },

  {
    "kshenoy/vim-signature",
  },

  {
    "dmmulroy/tsc.nvim",
    config = function()
      require("tsc").setup()
    end,
  },
}
