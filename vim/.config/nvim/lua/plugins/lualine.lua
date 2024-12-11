return {
  {
    "nvim-lualine/lualine.nvim",
    -- Hide the clock
    -- https://www.reddit.com/r/neovim/comments/1co1px4/comment/l3aytgo/
    opts = function(_, opts)
      opts.sections.lualine_z = {}
    end,
  },
}
