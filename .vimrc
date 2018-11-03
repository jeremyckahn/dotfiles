syntax enable
set number
set hlsearch
set incsearch
set nocp
set autoindent
set tabstop=2 shiftwidth=2 expandtab
set smartcase
set autoread
setlocal spelllang=en_us

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/CSS-one-line--multi-line-folding'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-markdown'
Plug 'vim-ruby/vim-ruby'
Plug 'ervandew/supertab'
Plug 'tpope/vim-sleuth'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'prettier/vim-prettier'
Plug 'dyng/ctrlsf.vim'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'janko-m/vim-test'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }
Plug 'bogado/file-line'

" Initialize plugin system
call plug#end()
filetype plugin indent on    " required

" http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/comment-page-1/
set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

" Force some file types to be other file types
au BufRead,BufNewFile *.ejs,*.mustache setfiletype html
au BufRead,BufNewFile *.json setfiletype json
au BufRead,BufNewFile *.json.* setfiletype json

" http://www.reddit.com/r/vim/comments/2x5yav/markdown_with_fenced_code_blocks_is_great/
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']

set wildignore+=**/bower_components/**,**/node_modules/**,**/dist/**,**/bin/**,**/tmp/**

let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_regexp_search = 0
let g:ctrlp_use_caching = 1

" Make OS X clipboard play nicely with Vim
" http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing
set clipboard=unnamed

" Write file with sudo permissions
" http://vim.wikia.com/wiki/Su-write
command W w !sudo tee % > /dev/null

" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

let mapleader = "\<Space>"

nmap <leader>E :Error<CR><C-w>j

let $FZF_DEFAULT_COMMAND = 'ack -l ""'

" Find files with fzf
nmap <leader>p :FZF<CR>
nmap <leader>P :Commands<CR>

let NERDTreeHijackNetrw=1
let NERDTreeShowHidden=1

let g:NERDSpaceDelims = 1

nmap <leader>n :NERDTreeToggle<Enter>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>d :w !diff % -<CR>
nmap <leader>D :bd<CR>

let g:tabman_toggle = '<leader>t'
let g:tabman_focus  = '<leader>T'

" Enable or disable auto width-formatting.
noremap <leader>f :call UnsetGutter()<CR>
noremap <leader>F :call SetGutter()<CR>

nmap <leader>b :Prettier<CR>

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

if has('mouse')
  set mouse=a
endif

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
" set visualbell


" --- backup and swap files ---
" I save all the time, those are annoying and unnecessary...
set nobackup
set nowritebackup
set noswapfile

set t_Co=256

" show hidden whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
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
noremap <leader>H :Helptags<CR>

" Make j and k work normally for soft wrapped lines
noremap <buffer> j gj
noremap <buffer> k gk

" Make the arrow keys work like TextMate in insert mode
inoremap <down> <C-C>gja
inoremap <up> <C-C>gka

nmap <leader>a :CtrlSF -R ""<Left>
nmap <leader>A <Plug>CtrlSFCwordPath -W<CR>
nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }

" Open Ggrep results in a quickfix window
autocmd QuickFixCmdPost *grep* cwindow

" Fix Vim's ridiculous line wrapping model
set ww=<,>,[,],h,l

noremap <C-H> :tabp<CR>
noremap <C-L> :tabn<CR>
noremap <C-J> :tabc<CR>
noremap <C-K> :tabe<CR>

nmap <C-t> :tab term<CR>
tmap <C-H> <C-w>:tabp<CR>
tmap <C-L> <C-w>:tabn<CR>
tmap <C-J> <C-w><C-c>
tmap <C-K> <C-w>:tabe<CR>

" Map <leader> + 1-9 to jump to respective tab
let i = 1
while i < 10
  execute ":noremap <leader>" . i . " :tabn " . i . "<CR>"
  let i += 1
endwhile

function! Tig ()
  silent !tig status
  redraw!
endfunction

" Open Tig and see the current Git diff
noremap <leader>t :call Tig()<CR>

" Open Misfit
"
" Requires misfit:
"   npm i -g misfit
noremap <leader>m :terminal misfit<CR>
noremap <leader>M :LivedownPreview<CR>

" Open the current buffer in a new tab
noremap <leader>z :tab split<CR>

colorscheme desertEx

" Always show the status line (for vim-powerline)
set laststatus=2

" Necessary to show Unicode glyphs
set encoding=utf-8

" Enable code folding for CoffeeScript
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

autocmd BufNewFile,BufReadPost *.js setl foldmethod=indent
autocmd BufNewFile,BufReadPost *.json setl foldmethod=indent

" Don't fold automatically https://stackoverflow.com/a/8316817
au BufRead * normal zR

setl foldmethod=syntax

let g:javascript_plugin_jsdoc = 1

" https://github.com/mxw/vim-jsx#usage
let g:jsx_ext_required = 0

let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'es5'

let g:ale_linters = {
\   'javascript': ['eslint'],
\}

nmap <silent> <C-n> <Plug>(ale_previous_wrap)
nmap <silent> <C-m> <Plug>(ale_next_wrap)

" Disable syntax highlighting for files over 1 MB
" https://stackoverflow.com/a/179103
autocmd BufReadPre * if getfsize(expand("%")) > 1000000 | syntax off | endif
autocmd BufEnter dist/* ALEDisableBuffer

let test#strategy = "vimterminal"
noremap tt :TestNearest<CR>

" https://medium.com/@rahul11061995/autocomplete-in-vim-for-js-developer-698c6275e341
" Don't show YCM's preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

noremap <leader>r :YcmRestartServer<CR>
noremap <leader>R :source ~/.vimrc<CR>

vmap <leader>s :'<,'>sort<CR>

let g:airline_powerline_fonts = 1

function! CRA ()
  tab term ++curwin
  tab term npm test
  tab term npm start
endfunction

command CRA execute ":call CRA()"
