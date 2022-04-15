" Always make help windows take up the full screen
" https://github.com/mephraim/dotfiles-etc/blob/f38ae
autocmd BufWinEnter * if &l:buftype ==# 'help' | only
