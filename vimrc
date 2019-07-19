
set nocompatible

" Plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-sensible'
Plugin 'ervandew/supertab'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
Plugin 'othree/html5.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'itchyny/calendar.vim'
Plugin 'w0rp/ale'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
call vundle#end()

filetype on
filetype plugin indent on
syntax on

" Snippets
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-d>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir="~/.vim/bundle/vim-snippets/UltiSnips"

" Setup for vim calendar
let g:calendar_google_calendar = 1


" Turn on vim autocomplete
set omnifunc=syntaxcomplete#Complete

set nu "add line numbers
set mouse=a
set textwidth=80
set clipboard=unnamed
set tags=./tags;/

" Get rid of auto-comment new lines
autocmd FileType * setlocal formatoptions -=c formatoptions -=r formatoptions -=o

" Force .md files to be recognized as markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" set autoindent spacing to use 4 single whitespaces
set shiftwidth=4
set tabstop=4
set expandtab

" Fix C++ indentation
setlocal autoindent
setlocal cindent
setlocal cinoptions=>s,e0,n0,f0,{0,}0,^0,L-1,:s,=s,l0,b0,gs,hs,ps,ts,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,m0,j0,J0,)20,*70,#0


let g:ale_linters = {
\   'python': ['flake8'],
\}
let g:ale_linters_explicit = 1

" Set indentation to 4 in python..... :(
au FileType python setl shiftwidth=4 tabstop=4 textwidth=79 fo+=t fo-=l
au BufNewFile,BufRead *.ejs set filetype=html

" Let leader key be comma key
let mapleader=","

" Shortcuts for CtrlP, Latex, TODOs, Calendar
map <leader>C :Calendar<CR>
map <C-p> :CtrlP<CR>
map <leader>l :Latexmk<CR>
:command! Skim execute ':silent! !open -ga skim %:r.pdf' | execute ':redraw!'
map <leader>o :Skim<CR>
map <leader>d :s/TODO\\|XXX/DONE/g<CR>
map <leader>b :split %:r.bib<CR>

" Fixes bugs with spellcheck in tex documents
if &filetype ==# 'tex'
  setlocal filetype=plaintex
endif

" let up and down movement be aware of screen wrap
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'

" Quick navigation
nnoremap J 5gj
nnoremap K 5gk
xnoremap J 5gj
xnoremap K 5gk
nnoremap H ^
nnoremap L $
xnoremap H ^
xnoremap L $

" NO AUTO WRAP
set textwidth=0
set wrapmargin=0

" Insert current date followed by day of the week
:nnoremap <C-d> "=strftime("%Y%m%d %A")<CR>P

" Quickly resize vertical splits
nnoremap <leader>> <C-w>10>
xnoremap <leader>> <C-w>10>
nnoremap <leader>< <C-w>10<
xnoremap <leader>< <C-w>10<

" For Vim-notes
let g:notes_title_sync = 'rename_file'
let g:notes_suffix = '.vnote'
let g:notes_directories = ['~/Notes']

" For Vimwiki lab notebook
let work_wiki = {}
let work_wiki.path = '~/Notes/Wiki/WorkWiki/'
let work_wiki.syntax = 'markdown'
let work_wiki.ext = '.md'
 
" For personal Vimwiki
let my_wiki = {}
let my_wiki.path = '~/Notes/Wiki/MyWiki/'
let my_wiki.syntax = 'markdown'
let my_wiki.ext = '.md'

let g:vimwiki_list = [work_wiki, my_wiki]

:command! MD2HTML execute ':!/Users/jeff/Notes/Wiki/scripts/wiki_md2html.bash %:p'

:command! AllMD2HTML execute ':!/Users/jeff/Notes/Wiki/scripts/wiki_allmd2html.bash %:p'

:command! MD2PDF execute ':!/Users/jeff/Notes/Wiki/scripts/md2pdf.bash %:p'

:command! MDView execute ':! grip %' | execute ':redraw!'

map <leader>wm :MD2HTML<CR>
map <leader>wl :AllMD2HTML<CR>
map <leader>wp :MD2PDF<CR>
 
" To quickly enter new buffer/return to previous buffer
nnoremap ff gf
xnoremap ff gf 
nnoremap fd :bprevious<CR>
xnoremap fd :bprevious<CR>

" Remaps for folding
nnoremap zz za
xnoremap zz za
nnoremap zo zr
xnoremap zo zr
nnoremap zc zm
xnoremap zc zm

" Set spellchecker
map <leader>sp :setlocal spell<CR>

" Show time in status bar
set ruler
set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

" Set ignore options
set wildignore+=*.o,spb_dynamics,*.default,*.equil,*.thermo,*.posit,*.initial_config,*.def,*.config,*.configurator,frames,mov*,*.log,*.d,*.aux,*.toc,*.pdf,*.fls,*.fdb_latexmk,*.blg,*.bbl,*.bib,*.png,*.tiff,*.jpg

" Python doc string
" doc string full
map <leader>dsf o"""Short docstring<ENTER><ENTER>Extended Docstring<ENTER><ENTER>Args:<ENTER>var1 (type): Input variable<ENTER><Enter><C-D>Returns:<ENTER>(type): Returned variable<ENTER><ENTER><C-D>"""<ESC>
" doc string short
map <leader>dss o""""""<ESC>hhi
