" Use vim settings, rather then vi settings (much better!)
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off                  " required for vundle

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tomasr/molokai'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI                                                                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on                              "color highlighting
set number                             "line numbers
set is                                 "incremental search
set background=dark                    "background dark/light
colorscheme molokai
"colorscheme solarized

set cc=80

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behavior                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set title " change the terminal's title
set fileformats="unix,dos,mac"
set wildmenu " make tab completion for files/buffers act like bash

" Backup files
set noswapfile

" tabs
set tabstop=2
set shiftwidth=2
set expandtab

set ruler "shows line and column number
set laststatus=2 "shows statusline

set hidden

" MacVim
if has("gui_running")
  set guioptions=egmrt       "diable toolbar
  set gfn=Menlo:h14          "set font
  colorscheme molokai
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remappings                                                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=","                      "change leader to ,

"reload configuration
noremap <F5> :execute 'so $MYVIMRC'<CR>

" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l        "split pane horizontal and set focus

" list buffers
"nnoremap <C-l> :execute 'ls'<CR>

" Rotate Buffers
nnoremap <Tab> :execute 'bn'<CR>
nnoremap <S-Tab> :execute 'bp'<CR>

"die buffer die
nnoremap <C-t> :execute 'bd'<CR>

" remove empty lines at end of file
" %s/\($\n\s*\)\+\%$//e


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto Commands                                                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespaces on write

" line numbering
autocmd FocusLost * :set number
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd CursorMoved * :set relativenumber

" Folding
"autocmd BufWinLeave * mkview              " save folds automatically
"autocmd BufWinEnter * silent loadview     " load folds automatically

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"nnoremap <F8> :call GetDate('')<CR>
function! GetDate(format)
  let format = empty(a:format) ? '+%A %Y-%m-%d %H:%M UTC' : a:format
  let cmd = '/bin/date -u ' . shellescape(format)
  let result = substitute(system(cmd), '[\]\|[[:cntrl:]]', '', 'g')
  " Append space + result to current line without moving cursor.
  call setline(line('.'), getline('.') . ' ' . result)
endfunction

nnoremap <F8> :call GetReleaseNotes('')<CR>
function! GetReleaseNotes(tag)
  "let format = empty(a:format) ? '$(git describe --abbrev=0)' : a:format
  let tag = system('git describe --abbrev=0')
  let cmd = '$(/usr/local/bin/git log --pretty=format:%s ' . shellescape(tag) . '..HEAD)'

  "let result = substitute(system(cmd), '[\]\|[[:cntrl:]]', '', 'g')
  " Append space + result to current line without moving cursor.
  "call setline(line('.'), getline('.') . ' ' . result)
  execute '$read !'. cmd
endfunction

" Fix indentation
map <F7> mzgg=G`z<CR>

" delete all html tags
" :%s/<\([^>]*\)>//g
