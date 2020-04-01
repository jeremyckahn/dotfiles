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

" https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md
set nomodeline

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/CSS-one-line--multi-line-folding'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'MobiusHorizons/fugitive-stash.vim'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-markdown'
Plug 'vim-ruby/vim-ruby'
Plug 'ervandew/supertab'
Plug 'tpope/vim-sleuth'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'prettier/vim-prettier'
Plug 'dyng/ctrlsf.vim'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }
Plug 'bogado/file-line'
Plug 'tpope/vim-eunuch'
Plug 'editorconfig/editorconfig-vim'
Plug 'moll/vim-node'
Plug 'mhinz/vim-startify'
Plug 'machakann/vim-highlightedyank'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim/killersheep'
Plug 'pechorin/any-jump.vim'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-pug'
Plug 'jacquesbh/vim-showmarks'

" https://freshman.tech/vim-javascript/#intelligent-code-completion
"
" To install language servers, manually call:
"   CocInstall coc-tsserver coc-json coc-html coc-css
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Initialize plugin system
call plug#end()
filetype plugin indent on    " required

colo hybrid_material

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

if has("macunix")
  set clipboard=unnamed
elseif has("unix")
  set clipboard=unnamedplus
endif

" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

let mapleader = "\<Space>"

nmap <leader>E :Error<CR><C-w>j

" Requires ripgrep
" https://github.com/BurntSushi/ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

nmap // :BLines!<CR>
nmap ?? :Rg!<CR>
noremap <leader>T :Commits!<CR>

" https://github.com/junegunn/fzf.vim/issues/162
let g:fzf_commands_expect = 'enter'

" Find files with fzf
nmap <leader>p :Files!<CR>

" Shows Git history for the current buffer
command! FileHistory execute ":BCommits!"

nmap cc :Commands<CR>

let NERDTreeHijackNetrw=1
let NERDTreeShowHidden=1

let g:NERDSpaceDelims = 1

function! ToggleNERDTree()
  NERDTreeToggle
  silent NERDTreeMirror
endfunction

nmap <leader>n :call ToggleNERDTree()<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>Q :qa!<CR>
nmap <leader>d :w !diff % -<CR>
nmap <leader>D :bd<CR>

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

command! CleanJson execute "!jsonlint % > /tmp/json && mv /tmp/json %"

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

nmap ss :set syntax=off<CR>
nmap SS :set syntax=on<CR>

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

" Insert common snippets
inoremap <C-c> console.log(
inoremap <C-d> describe('', () => {});<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
inoremap <C-t> test('', () => {});<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
inoremap <C-b> beforeEach(() => {});<Left><Left><Left>

nmap <leader>a :CtrlSF -R ""<Left>
nmap <leader>A <Plug>CtrlSFCwordPath -W<CR>
nmap <leader>c :CtrlSFFocus<CR>
nmap <leader>C :CtrlSFToggle<CR>

if has("macunix")
  let g:ctrlsf_ackprg = '/usr/local/bin/rg'
elseif has("unix")
  let g:ctrlsf_ackprg = '/usr/bin/rg'
endif

let g:ctrlsf_winsize = '33%'
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
noremap <C-Y> :tabm -1<CR>
noremap <C-L> :tabn<CR>
noremap <C-P> :tabm +1<CR>
noremap <C-J> :tabc<CR>
noremap <C-K> :tabe <Bar> Startify<CR>

nmap <leader>t :tab term<CR>source $HOME/.bash_profile<CR>clear<CR>
tmap <C-H> <C-w>:tabp<CR>
tmap <C-Y> <C-w>:tabm -1<CR>
tmap <C-L> <C-w>:tabn<CR>
tmap <C-P> <C-w>:tabm +1<CR>
tmap <C-J> <C-w><C-c>
tmap <C-K> <C-w>:tabe <Bar> Startify<CR>

" https://github.com/vim/vim/issues/2490#issuecomment-383382372
tmap <C-b> <C-W>N

" Map <leader> + 1-9 to jump to respective tab
let i = 1
while i < 10
  execute ":nmap <leader>" . i . " :tabn " . i . "<CR>"
  let i += 1
endwhile

" Open and close lazygit
noremap <leader>g :tab term ++close lazygit<CR>

noremap <leader>M :LivedownPreview<CR>

" Open the current buffer in a new tab
noremap <leader>z :tab split<CR>

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

autocmd BufEnter dist/* ALEDisableBuffer

" https://medium.com/@rahul11061995/autocomplete-in-vim-for-js-developer-698c6275e341
" Don't show YCM's preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

noremap <leader>r :YcmRestartServer<CR>
noremap <leader>R :source ~/.vimrc<CR>

vmap <leader>s :'<,'>sort<CR>

function! CRA ()
  tab term ++curwin
  tab term npm test
  tab term npm start
endfunction

" Quickly run tests
nmap tt :term ++close npm test<CR>

command! CRA execute ":call CRA()"
command! Reload execute "source ~/.vimrc"

" This is handled by lightline
set noshowmode

" Show file path in lightline
" https://github.com/itchyny/lightline.vim/issues/87#issuecomment-119130738
let g:lightline = {
  \ 'colorscheme': 'darcula',
  \ 'active': {
  \   'right': [['lineinfo'], ['fileformat', 'filetype']]
  \ },
  \ 'component_function': {
  \   'filename': 'LightLineFilename'
  \ },
  \ 'component': {
  \   'lineinfo': "[%l:%-v] [%{printf('%03d/%03d',line('.'),line('$'))}]",
  \ }
  \ }
function! LightLineFilename()
  return expand('%')
endfunction

" Reload file on focus/enter
" https://stackoverflow.com/a/20418591
au FocusGained,BufEnter * :silent! !

let g:highlightedyank_highlight_duration = 200

command! Filename execute ":echo expand('%:p')"
command! Config execute ":e $MYVIMRC"

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Print the number of occurrences of the current word under the cursor
" (comma + *)
map ,* *<C-O>:%s///gn<CR>

" Run a command on all tabs and return to the current tab
" https://vim.fandom.com/wiki/Run_a_command_in_multiple_buffers#Restoring_position
function! TabDo(command)
  let currTab=tabpagenr()
  execute 'tabdo ' . a:command
  execute 'tabn ' . currTab
endfunction
com! -nargs=+ -complete=command Tabdo call TabDo(<q-args>)

" Resize splits in all tabs upon window resize
" https://vi.stackexchange.com/a/206
autocmd VimResized * Tabdo wincmd =
