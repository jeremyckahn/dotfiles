-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.cmd([[colo catppuccin-mocha]])

vim.api.nvim_create_user_command("Reload", [[execute "source ~/.config/nvim/init.lua"]], { desc = "Reload the config" })

vim.o.wrap = true
vim.o.relativenumber = false

vim.g.snacks_animate = false

vim.keymap.set("i", "jj", [[<Esc>]])
