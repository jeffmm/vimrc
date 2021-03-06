" Set up vim notes/wiki to use encrypted folder with pCloud
let crypto = system("[ -r ~/pCloud\\ Drive/Crypto\\ Folder/Notes ] && echo 1 || echo 0".shellescape(expand('%:h')))

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
Plugin 'xolox/vim-misc'
Plugin 'othree/html5.vim'
if crypto
  Plugin 'vimwiki/vimwiki'
endif
Plugin 'w0rp/ale'
"Plugin 'tpope/vim-surround'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
call vundle#end()

filetype on
filetype plugin indent on
syntax on

" Snippets
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/bundle/vim-snippets/UltiSnips"
let g:ultisnips_python_style="google"

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

let g:ale_linters = {
\   'python': ['flake8'],
\   'cpp': ['clangtidy'],
\   'c': ['clangtidy'],
\   'sh': ['language_server', 'shell', 'shellcheck']
\}
let g:ale_fixers = {
\   'python': ['black', 'remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clang-format', 'remove_trailing_lines', 'trim_whitespace'],
\   'c': ['clang-format', 'remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['shfmt', 'remove_trailing_lines', 'trim_whitespace']
\}

let g:ale_sh_shell_default_shell = 'bash'
"let g:ale_c_clangformat_options = "-style={BasedOnStyle: Google, IndentWidth: 4}"
let g:ale_python_black_options = "-l 88"
let g:ale_python_flake8_options = "--max-line-length 88 --ignore E203 --max-complexity 10"
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 0
let g:ale_lint_on_save = 1

au FileType cpp setl autoindent expandtab shiftwidth=2 tabstop=2 textwidth=80 fo+=t fo-=l
au FileType python setl shiftwidth=4 tabstop=4 textwidth=88 fo+=t fo-=l
au FileType yaml setl shiftwidth=2 tabstop=2 textwidth=98 fo+=t fo-=l
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.tpp set filetype=cpp

" Let leader key be comma key
let mapleader=","

" Shortcuts for CtrlP, Latex, TODOs, Calendar
map <leader>C :Calendar<CR>
map <C-p> :CtrlP<CR>
map <leader>l :Latexmk<CR>
:command! Skim execute ':silent! !open -ga skim %:r.pdf' | execute ':redraw!'
map <leader>o :Skim<CR>
map <leader>b :split %:r.bib<CR>
map fq :ALEFix<CR>
let g:gitgutter_max_signs=10000

" Fixes bugs with spellcheck in tex documents
if &filetype ==# 'tex'
  setlocal filetype=plaintex
endif

" let up and down movement be aware of screen wrap
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <expr> J v:count ? '5j' : '5gj'
nnoremap <expr> K v:count ? '5k' : '5gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> J v:count ? '5j' : '5gj'
xnoremap <expr> K v:count ? '5k' : '5gk'

nnoremap H g^
nnoremap L g$
xnoremap H g^
xnoremap L g$
" NO AUTO WRAP
set textwidth=0
set wrapmargin=0
" Insert current date followed by day of the week in markdown syntax
noremap <leader>d "=strftime("## %Y%m%d %A")<CR>P
" Quickly resize vertical splits
nnoremap <leader>> <C-w>10>
xnoremap <leader>> <C-w>10>
nnoremap <leader>< <C-w>10<
xnoremap <leader>< <C-w>10<

" If Crypto Folder is unlocked, initialize vim notes
if crypto

    " For Vim-notes
    let g:notes_title_sync = 'rename_file'
    let g:notes_suffix = '.vnote'
    let g:notes_directories = ['~/pCloud\ Drive/Crypto\ Folder/Notes']

    " For Vimwiki lab notebook
    let work_wiki = {}
    let work_wiki.path = '~/pCloud\ Drive/Crypto\ Folder/Notes/Wiki/WorkWiki/'
    let work_wiki.syntax = 'markdown'
    let work_wiki.ext = '.md'
     
    " For personal Vimwiki
    let my_wiki = {}
    let my_wiki.path = '~/pCloud\ Drive/Crypto\ Folder/Notes/Wiki/MyWiki/'
    let my_wiki.syntax = 'markdown'
    let my_wiki.ext = '.md'

    let g:vimwiki_list = [my_wiki, work_wiki]

    " Disable folding in vimwiki
    let g:vimwiki_conceallevel = 0
    let g:vimwiki_url_maxsave = 0

    :command! MD2PDF execute ':!/Users/jeff/pCloud\ Drive/Misc/md2pdf.bash %:p'

    :command! MDView execute ':! grip %' | execute ':redraw!'
    map <leader>wp :MD2PDF<CR>

else
    " If crypto folder is locked, let the me know that I can't use vim notes/wiki
    map <leader>ww :echo "Crypto folder is locked. Vim notes disabled"<CR>
    map 2<leader>ww :echo "Crypto folder is locked. Vim notes disabled"<CR>

endif
 
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

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir': 'data',
  \ 'file': '\v\.(exe|so|dll|ipynb)$',
  \ }

" Python doc string
" doc string full
map <leader>dsf o"""Short docstring<ENTER><ENTER>Extended Docstring<ENTER><ENTER>Args:<ENTER>var1 (type): Input variable<ENTER><Enter><C-D>Returns:<ENTER>(type): Returned variable<ENTER><ENTER><C-D>"""<ESC>
" doc string short
map <leader>dss o""""""<ESC>hhi
map <leader>sn :call UltiSnips#ListSnippets()<CR>

