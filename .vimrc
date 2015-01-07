" See this link for installing Command-T for OS X:
" http://railslove.com/blog/2011/10/17/installing-macvim-with-ruby-support-and-command-t-on-osx-lion

syntax enable
set number
set hlsearch
set incsearch
set nocp
set autoindent
set tabstop=2 shiftwidth=2 expandtab
set smartcase
setlocal spelllang=en_us

" http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/comment-page-1/
set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

" Force some file types to be other file types
au BufRead,BufNewFile *.ejs,*.mustache setfiletype html
au BufRead,BufNewFile *.md setfiletype markdown
au BufRead,BufNewFile *.json setfiletype json

call pathogen#infect()
call pathogen#helptags()

set wildignore+=**/bower_components/**,**/node_modules/**,**/dist/**,**/bin/**

let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_regexp_search = 0
let g:ctrlp_use_caching = 1

" Make OS X clipboard play nicely with Vim
" http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

" Write file with sudo permissions
" http://vim.wikia.com/wiki/Su-write
command W w !sudo tee % > /dev/null

" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

let mapleader = ","

nmap <leader>E :Error<CR><C-w>j

" Find files with ctrlp
nmap <leader>p :CtrlP<CR>
nmap <leader>P :CtrlPClearCache<CR>

nmap <leader>n :NERDTreeToggle<Enter>
nmap <leader>d :w !diff % -<CR>

let g:tabman_toggle = '<leader>t'
let g:tabman_focus  = '<leader>T'

" Enable or disable auto width-formatting.
noremap <leader>f :call UnsetGutter()<CR>
noremap <leader>F :call SetGutter()<CR>

" Disable Ex mode
nmap Q <Nop>

" Substitute the word under the cursor.
nmap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

function! SetGutter()
  set tw=79
  exec 'set colorcolumn=' . join(range(80, 500), ',')
endfunction

function! UnsetGutter()
  set tw=0
  set colorcolumn=0
endfunction

command CleanJson execute "!jsonlint % > /tmp/json && mv /tmp/json %"

 autocmd BufWritePre * :%s/\s\+$//e
"|             |                  | |
"|             |                  | This part actually removes the whitespace
"|             |                  The command will run for all file types
"|             This command will run immediately after you save a file
"Creates a new autocommand

"if has('mouse')
  "set mouse=a
"endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow buffer switching without saving
set hidden

"Case insensitive search.
set ic

" Gui stuff
if has("gui_running")
  set lines=150 columns=230 " Maximize gvim window.

  set guioptions-=T " Get rid of the toolbar
  set guioptions-=e " Get rid of the GUI tabs
  set guioptions-=r " Get rid of the right scrollbar
  set guioptions-=R " Get rid of the right scrollbar
  set guioptions-=l " Get rid of the left scrollbar
  set guioptions-=L " Get rid of the left scrollbar
  set guioptions-=b " Get rid of the bottom scrollbar
endif

:set backspace=indent,eol,start

" --- command completion ---
set wildmenu                " Hitting TAB in command mode will
set wildchar=<TAB>          "   show possible completions.
set wildmode=list:longest
set wildignore+=*.DS_STORE,*.db


" --- remove sounds effects ---
set noerrorbells
set visualbell


" --- backup and swap files ---
" I save all the time, those are annoying and unnecessary...
set nobackup
set nowritebackup
set noswapfile

set t_Co=256

" http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
hi x233_Grey7 ctermfg=233 guifg=#121212
hi ColorColumn ctermbg=233_Grey7

" show hidden whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Allow cursor movements during insert mode
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
inoremap <C-d> <end>

" hitting jj will jump out of insert mode
inoremap jj <esc>

" quick vertical split
noremap <leader>v :vsp<CR><C-w><C-w>

" Quickly get rid of highlighting
noremap <leader>h :noh<CR>

" Make j and k work normally for soft wrapped lines
noremap <buffer> j gj
noremap <buffer> k gk

" Make the arrow keys work like TextMate in insert mode
inoremap <down> <C-C>gja
inoremap <up> <C-C>gka

" https://github.com/mileszs/ack.vim
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Open a new tab and search for something.
nmap <leader>a :tab split<CR>:Ack ""<Left>

" Immediately search for the word under the cursor in a new tab.
nmap <leader>A :tab split<CR>:Ack "\W<C-r><C-w>\W"<CR>

let g:unite_source_grep_command = 'ack-grep'
let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
let g:unite_source_grep_recursive_opt = ''

" Open Ggrep results in a quickfix window
autocmd QuickFixCmdPost *grep* cwindow

" Fix Vim's ridiculous line wrapping model
set ww=<,>,[,],h,l

noremap <C-H> :tabp<CR>
noremap <C-L> :tabn<CR>
noremap <C-J> :tabc<CR>
noremap <C-K> :tabe<CR>

function! Tig ()
  silent !tig status
  redraw!
endfunction

" Open Tig and see the current Git diff
noremap <C-t> :call Tig()<CR>

" Open the current buffer in a new tab
noremap <leader>z :tab split<CR>

colorscheme desertEx

" Always show the status line (for vim-powerline)
set laststatus=2

" Necessary to show Unicode glyphs
set encoding=utf-8

" Enable code folding for CoffeeScript
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
