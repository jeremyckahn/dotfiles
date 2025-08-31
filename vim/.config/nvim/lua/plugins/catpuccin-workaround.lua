-- See: https://github.com/LazyVim/LazyVim/issues/6355#issuecomment-3212986215
return {
  "catppuccin/nvim",
  opts = function(_, opts)
    local module = require("catppuccin.groups.integrations.bufferline")
    if module then
      module.get = module.get_theme
    end
    return opts
  end,
}
