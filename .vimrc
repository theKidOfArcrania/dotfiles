" Prerequisites:
" exuberant ctags, npm, yarn, coqide, build essential, hasktags
"

au BufNewFile,BufRead *.s,*.S,*.mal set filetype=mips
au BufNewFile,BufRead *.pro set filetype=prolog
" Coq proof files
au BufRead,BufNewFile *.v set filetype=coq
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set laststatus=2

set termguicolors

set textwidth=80
set fo+=t
set wrap
set ai

set foldmethod=syntax
set nofoldenable

set ff=unix
set number

set relativenumber

set modeline

" let g:clang_library_path='/home/henry/llvm/lib/'
let g:clang_library_path='/usr/lib/llvm-11/lib'

let g:coc_disable_startup_warning = 1

let g:tex_items = '\\bibitem\|\\item\|\\bitem'
"let g:tex_items = '\\bibitem\|\\item\|\\bitem'
let g:tex_ident_items = 1
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
let g:ycm_confirm_extra_conf = 1

let g:syntastic_mode_map = { 'mode': 'active',
                            \ 'active_filetypes': ['javascript', 'typescript'],
                            \ 'passive_filetypes': [] }
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['eslint']
let g:tagbar_type_haskell = {
    \ 'ctagsbin'    : 'hasktags',
    \ 'ctagsargs'   : '-x -c -o-',
    \ 'kinds'       : [
        \  'm:modules:0:1',
        \  'd:data:0:1',
        \  'd_gadt:data gadt:0:1',
        \  'nt:newtype:0:1',
        \  'c:classes:0:1',
        \  'i:instances:0:1',
        \  'cons:constructors:0:1',
        \  'c_gadt:constructor gadt:0:1',
        \  'c_a:constructor accessors:1:1',
        \  't:type names:0:1',
        \  'pt:pattern types:0:1',
        \  'pi:pattern implementations:0:1',
        \  'ft:function types:0:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'          : '.',
    \ 'kind2scope'   : {
        \ 'm'        : 'module',
        \ 'd'        : 'data',
        \ 'd_gadt'   : 'd_gadt',
        \ 'c_gadt'   : 'c_gadt',
        \ 'nt'       : 'newtype',
        \ 'cons'     : 'cons',
        \ 'c_a'      : 'accessor',
        \ 'c'        : 'class',
        \ 'i'        : 'instance'
    \ },
    \ 'scope2kind'   : {
        \ 'module'   : 'm',
        \ 'data'     : 'd',
        \ 'newtype'  : 'nt',
        \ 'cons'     : 'c_a',
        \ 'd_gadt'   : 'c_gadt',
        \ 'class'    : 'ft',
        \ 'instance' : 'ft'
    \ }
\ }

let g:coq_on = 0
fu! CoqToggle()
  if g:coq_on
    CoqQuit
    let g:coq_on = 0
  else
    CoqStart
    let g:coq_on = 1
  endif
endf

nmap <F8> :TagbarToggle<CR>

inoremap <C-\> λ

nnoremap <F2> :call CoqToggle()<CR>
nnoremap <leader>j :CoqNext<CR>
nnoremap <leader>k :CoqRewind<CR>
nnoremap <leader>l :CoqToCursor<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set colorcolumn=80

"nmap <F2> :FZF<CR>
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>
nmap <F5> :source ~/.vimrc<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

inoremap <C-\> λ

"nnoremap <leader>jd :YcmCompleter GoTo<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Formatting selected code.
xmap <leader>F  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format-selected)

" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

"inoremap <silent><expr> ( complete_parameter#pre_complete("()")
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Highlight extra spaces
autocmd ColorScheme * hi ExtraWhitespace ctermbg=red guibg=red
hi ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

call plug#begin('~/.vim/plugged')

" Code completion
" Plug 'valloric/youcompleteme', {'do': 'install.py --all'}
Plug 'raimondi/delimitmate'
" Plug 'tenfyzhong/completeparameter.vim'

" GUI Interface
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'

Plug 'myusuf3/numbers.vim'

" Languages
Plug 'briancollins/vim-jst'
Plug 'pangloss/vim-javascript'
Plug 'justinmk/vim-syntax-extra'
Plug 'scrooloose/syntastic'
Plug 'Quramy/tsuquyomi'
Plug 'Superbil/llvm.vim'
Plug 'xavierd/clang_complete'

" Coq
Plug 'https://framagit.org/manu/coq-au-vim'
Plug 'https://github.com/jvoorhis/coq.vim'

" Haskell
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neovimhaskell/haskell-vim'
" Plug 'alx741/vim-hindent' " Optional

" Other stuff
Plug 'tpope/vim-eunuch'
Plug 'terryma/vim-multiple-cursors'
Plug '~/.vimlocal/elflord2'
Plug 'leafgarland/typescript-vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'fidian/hexmode'

call plug#end()

colorscheme elflord2

