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
Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'itchyny/lightline.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
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
Plug 'pechorin/any-jump.vim'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-pug'
Plug 'jacquesbh/vim-showmarks'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-shell'
Plug 'RRethy/vim-illuminate'
Plug 'rhysd/git-messenger.vim'
Plug 'voldikss/vim-floaterm'
Plug 'antoinemadec/coc-fzf'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'kshenoy/vim-signature'

" https://freshman.tech/vim-javascript/#intelligent-code-completion
"
" To install language servers, manually call:
"   CocInstall coc-tsserver coc-json coc-html coc-css
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Initialize plugin system
call plug#end()
filetype plugin indent on    " required

colo vim-monokai-tasty

" http://damien.lespiau.name/blog/2009/03/18/per-project-vimrc/comment-page-1/
" set exrc " enable per-directory .vimrc files
set secure " disable unsafe commands in local .vimrc files

" Ensure that :Reload-ing the file doesn't define redundant autocmds
" https://learnvimscriptthehardway.stevelosh.com/chapters/14.html
augroup standard_group
  autocmd!

  " Force some file types to be other file types
  autocmd BufRead,BufNewFile *.ejs,*.mustache setfiletype html
  autocmd BufRead,BufNewFile *.json setfiletype json
  autocmd BufRead,BufNewFile *.json.* setfiletype json
  autocmd BufEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

  " http://www.reddit.com/r/vim/comments/2x5yav/markdown_with_fenced_code_blocks_is_great/
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown

  autocmd BufNewFile,BufReadPost *.jenkinsfile set filetype=groovy

  " Enable code folding for CoffeeScript
  autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable

  autocmd BufNewFile,BufReadPost *.js setl foldmethod=indent
  autocmd BufNewFile,BufReadPost *.json setl foldmethod=indent

  " Don't fold automatically https://stackoverflow.com/a/8316817
  autocmd BufRead * normal zR

  " Open Ggrep results in a quickfix window
  autocmd QuickFixCmdPost *grep* cwindow

  autocmd BufEnter dist/* ALEDisableBuffer

  " Resize splits in all tabs upon window resize
  " https://vi.stackexchange.com/a/206
  autocmd VimResized * Tabdo wincmd =

  " Reload file on focus/enter. This seems to break in Windows.
  " https://stackoverflow.com/a/20418591
  if !has("win32")
    autocmd FocusGained,BufEnter * :silent! !
  endif
augroup END

let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html']

set wildignore+=**/bower_components/**,**/node_modules/**,**/dist/**,**/bin/**,**/tmp/**

let g:ctrlp_working_path_mode = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_regexp_search = 0
let g:ctrlp_use_caching = 1

" https://github.com/xolox/vim-shell#the-gshell_fullscreen_items-option
let g:shell_fullscreen_items = "mT"
let g:shell_fullscreen_always_on_top = 0

if has("macunix") || has('win32')
  set clipboard=unnamed
elseif has("unix")
  set clipboard=unnamedplus
endif

" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

let mapleader = "\<Space>"

nmap <leader>E :Error<CR><C-w>j

" Toggle line numbers
nmap <leader>N :set number!<CR>

" Requires ripgrep
" https://github.com/BurntSushi/ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git/*"'

if has('win32')
  " Disable preview on Windows since it doesn't really work
  let g:fzf_preview_window = ''
else
  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endif

let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95 } }

nmap // :BLines<CR>
nmap ?? :Rg<CR>

" https://github.com/junegunn/fzf.vim/issues/162
let g:fzf_commands_expect = 'enter'

" Find files with fzf
nmap <leader>p :Files<CR>

" Shows Git history for the current buffer
command! FileHistory execute ":BCommits"

nmap cc :Commands<CR>

" Delete buffers
" https://github.com/junegunn/fzf.vim/pull/733#issuecomment-559720813
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

command! B execute "Buffers"

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
  " https://vi.stackexchange.com/a/521
  set mouse=a
  if !has('nvim')
    set ttymouse=xterm2
  endif
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
  set guifont=Ubuntu_Mono:h14

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

" Fix Vim's ridiculous line wrapping model
set ww=<,>,[,],h,l

noremap <C-h> :tabp<CR>
noremap - :tabm -1<CR>
noremap <C-l> :tabn<CR>
noremap = :tabm +1<CR>
noremap <C-j> :tabc<CR>
noremap <C-k> :tabe <Bar> Startify<CR>

if has('win32')
  nmap <leader>t :tab term<CR>
else
  nmap <leader>t :FloatermNew<CR>
endif

tmap <C-h> <C-w>:tabp<CR>
tmap <C-y> <C-w>:tabm -1<CR>
tmap <C-l> <C-w>:tabn<CR>
tmap <C-p> <C-w>:tabm +1<CR>
tmap <C-j> <C-w><C-c>
tmap <C-k> <C-w>:tabe <Bar> Startify<CR>

let g:startify_change_to_dir=0

" Map <leader> + 1-9 to jump to respective tab
let i = 1
while i < 10
  execute ":nmap <leader>" . i . " :tabn " . i . "<CR>"
  let i += 1
endwhile

nmap <leader>g :FloatermNew! EDITOR=floaterm bash -c 'lazygit'; exit<CR>

noremap <leader>M :LivedownPreview<CR>

" Open the current buffer in a new tab
noremap <leader>z :tab split<CR>

" Always show the status line (for vim-powerline)
set laststatus=2

" Necessary to show Unicode glyphs
set encoding=utf-8

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

" https://medium.com/@rahul11061995/autocomplete-in-vim-for-js-developer-698c6275e341
" Don't show YCM's preview window
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

noremap <leader>r :YcmRestartServer<CR>
noremap <leader>R :source ~/.vimrc<CR>

vmap <leader>s :'<,'>sort<CR>

command! NPMStart execute "FloatermNew npm start"
command! NPMTest execute "FloatermNew npm test -- --watch"

function! JS ()
  FloatermNew
  NPMStart
  NPMTest
endfunction

function! L ()
  tab term ++curwin
  tab term lazygit
  tab term lazynpm
endfunction

command! JS execute ":call JS()"
command! L execute ":call L()"
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

let g:highlightedyank_highlight_duration = 200

command! Filename execute ":echo expand('%:p')"
command! Config execute ":e $MYVIMRC"

let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

nnoremap <silent> gl :CocFzfListResume<CR>

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

" Format selected code.
xmap <leader>b  <Plug>(coc-format-selected)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>

" https://github.com/weirongxu/coc-explorer
" :CocInstall coc-explorer
nmap <leader>e :CocCommand explorer --position floating<CR>

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

let g:git_messenger_always_into_popup=v:true

let g:floaterm_autoclose=1
let g:floaterm_height=0.95
let g:floaterm_width=0.95

let g:floaterm_keymap_toggle = '<C-f>'

tnoremap <silent> <C-h> <C-\><C-n>:FloatermPrev<CR>
tnoremap <silent> <C-l> <C-\><C-n>:FloatermNext<CR>
tnoremap <silent> <C-j> <C-\><C-n>:FloatermKill<CR>
tnoremap <silent> <C-k> <C-\><C-n>:FloatermNew<CR>

" Break floaterm execution into Normal mode
tnoremap <silent> <C-b> <C-\><C-n>
