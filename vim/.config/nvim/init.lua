vim.cmd("mapclear")
require("config.lazy")

vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

vim.o.number = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.autoindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartcase = true
vim.o.secure = true
vim.o.autoread = true
vim.o.undofile = true
vim.o.undodir= "~/.vim/undodir"
vim.o.ic = true -- Case insensitive search.
vim.o.errorbells = false -- Remove sounds effects

vim.opt.spelllang = "en_us"
vim.opt.modeline = false
vim.opt.cursorline = true
vim.opt.sessionoptions:remove{"blank"}
vim.opt.sessionoptions:remove{"buffers"}
vim.opt.sessionoptions:remove{"winsize"}

vim.g.mapleader = " " -- Set leader to the space bar

vim.cmd.highlight({ "Search", "guibg=Yellow guifg=Black" })
vim.cmd.highlight({ "Comment", "cterm=italic" })
vim.cmd.highlight({ "ExtraWhitespace", "ctermbg=red guibg=red" })

local autocommand_group = vim.api.nvim_create_augroup('vimrc', { clear = true })

-- Trim whitespace on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "*",
  group = autocommand_group,
  command = [[%s/\s\+$//e]],
})

-- Don't fold automatically https://stackoverflow.com/a/8316817
vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = "*",
  group = autocommand_group,
  command = [[normal zR]],
})

-- Resize splits in all tabs upon window resize https://vi.stackexchange.com/a/206
vim.api.nvim_create_autocmd({ "VimResized" }, {
  pattern = "*",
  group = autocommand_group,
  command = [[Tabdo wincmd =]],
})

-- Reload file on focus/enter https://stackoverflow.com/a/20418591
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  group = autocommand_group,
  command = [[:silent! !]],
})

-- http://www.reddit.com/r/vim/comments/2x5yav/markdown_with_fenced_code_blocks_is_great/
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.md",
  group = autocommand_group,
  command = [[set filetype=markdown]],
})

-- Enable comments in JSON files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.json",
  group = autocommand_group,
  command = [[set filetype=jsonc]],
})

if vim.fn.has("macunix") == 1 or vim.fn.has("win32") == 1 then
  vim.o.clipboard = "unnamed"
elseif vim.fn.has("unix") == 1 then
  vim.o.clipboard = "unnamedplus"
end

vim.keymap.set("n", "<C-s>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- Substitute the word under the cursor.
vim.keymap.set("n", "<leader>z", [[:tab split<cr>]])
vim.keymap.set("i", "jj", [[<Esc>]])

-- Map g + 1-9 to jump to respective tab
for i = 1, 9 do vim.keymap.set("n", "g" .. i, ":tabn " .. i .. "<cr>") end

vim.api.nvim_create_user_command("Reload", [[execute "source ~/.config/nvim/init.lua"]], {})
