set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'tmhedberg/SimpylFold' " code folding plugin
Plugin 'vim-scripts/indentpython.vim' " auto-indentation plugin for PEP 8
Plugin 'vim-syntastic/syntastic' " sintax plugin
Plugin 'nvie/vim-flake8' " PEP 8 checking linter plugin
Plugin 'altercation/vim-colors-solarized' " color scheme for GUI
Plugin 'scrooloose/nerdtree' " file browsing plugin
Plugin 'jistr/vim-nerdtree-tabs' " file browsing with tabs plugin
Plugin 'kien/ctrlp.vim' " super searching plugin
Plugin 'tpope/vim-fugitive' " git integration plugin
Plugin 'vim-airline/vim-airline' " vim status bar plugin
Plugin 'vim-airline/vim-airline-themes' " vim status bar themes
Plugin 'jmcantrell/vim-virtualenv' " activate deactivate python virtualenv plugin
"Plugin 'psf/black' " code auto formatted with Black (works with Python 3.6 - https://github.com/psf/black) 
" :PluginClean for these plugins
" Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} " status bar that displays current virtualenv, git branch, files
" Plugin 'Xuyuanp/nerdtree-git-plugin'git for NERDTree plugin
" Plugin 'Valloric/YouCompleteMe'

colorscheme dogrun

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" make your code loop pretty
let python_highlight_all=1
syntax on

" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

set splitbelow
set splitright

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" save and run current python code
nnoremap <F5> ::w!<CR>:!clear;python %<CR>

" just run current python code
nnoremap <F6> :!clear;python %<CR>

" map NERDTree on F3
map <F3> :NERDTreeToggle<CR>

" Ctrl-Left or Ctrl-Right to go to the previous or next tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
" Alt-Left or Alt-Right to move the current tab to the left or right
nnoremap <silent> <C-Down> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-Up> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" switching to another buffer manually - https://vim.fandom.com/wiki/Using_tab_pages
" :help switchbuf
set switchbuf=usetab
nnoremap <F7> :sbnext<CR>
nnoremap <S-F7> :sbprevious<CR>

" manual black code reformatting
nnoremap <F9> :w<CR>:!clear;black %<CR>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" paste code without auto-indent like this - https://vim.fandom.com/wiki/Toggle_auto-indenting_for_code_paste
set pastetoggle=<F2>

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/undodir

let g:SimpylFold_docstring_preview=1

au BufRead,BufNewFile *.py,*pyw set tabstop=4
au BufRead,BufNewFile *.py,*pyw set softtabstop=4
au BufRead,BufNewFile *.py,*pyw set autoindent
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h set textwidth=79
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" for full stack development
au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2
au BufNewFile,BufRead *.js, *.html, *.css set shiftwidth=2 
au BufNewFile,BufRead *.js, *.html, *.css set softtabstop=2

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

" to run NERDTreeTabs on console vim startup
"let g:nerdtree_tabs_open_on_console_startup=1

" line numbering
"set nu

" air-line settings 
" enable tab line with vim-airline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_theme='minimalist'
let g:airline_section_y = '%{virtualenv#statusline()}'

" to add fugitive plugin (for git) in statusline
let g:airline_section_b = '%{FugitiveStatusline()}'
