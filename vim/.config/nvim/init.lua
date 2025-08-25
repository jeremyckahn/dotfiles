-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[colo catppuccin-mocha]])

vim.api.nvim_create_user_command("Reload", [[execute "source ~/.config/nvim/init.lua"]], { desc = "Reload the config" })

vim.o.wrap = true
vim.o.relativenumber = false

vim.g.snacks_animate = false

vim.keymap.set("i", "jj", [[<Esc>]])

-- Override standard config:
-- https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/config/options.lua#L105C1-L105C46
vim.opt.timeoutlen = 1000
