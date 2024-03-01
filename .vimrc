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
set tabpagemax=100

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
    CoqStop
    let g:coq_on = 0
  else
    CoqStart
    let g:coq_on = 1
  endif
endf

nmap <F8> :TagbarToggle<CR>

inoremap <C-\> λ
inoremap <C-e> ε
inoremap <C-O> Ø

nnoremap <F2> :call CoqToggle()<CR>
nnoremap <C-Down>  :CoqNext<CR>
nnoremap <C-Up>    :CoqUndo<CR>
nnoremap <C-Right> :CoqToLine<CR>
inoremap <C-Down>  <C-\><C-o>:CoqNext<CR>
inoremap <C-Up>    <C-\><C-o>:CoqUndo<CR>
inoremap <C-Right> <C-\><C-o>:CoqToLine<CR>

inoremap <leader>cj  <C-\><C-o>:CoqNext<CR>
inoremap <leader>ck    <C-\><C-o>:CoqUndo<CR>
inoremap <leader>cl <C-\><C-o>:CoqToLine<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nnoremap <leader>rn <Plug>(coc-rename)

" Formatting
xnoremap <leader>f <Plug>(coc-format-selected)
nnoremap <leader>f <Plug>(coc-format-selected)


set exrc

set statusline+=%#warningmsg#
set statusline+=%*

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

set colorcolumn=80

"nmap <F2> :FZF<CR>
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>
nmap <F5> :source ~/.vimrc<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

inoremap <C-\> λ

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

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

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>m  :CocCommand rust-analyzer.expandMacro<cr>

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

augroup CoqtailHighlights
  autocmd!
  autocmd ColorScheme *
    \  hi default CoqtailSent    guibg=#661100 ctermbg=darkred
    \| hi default CoqtailChecked guibg=#113300 ctermbg=darkgreen
augroup END

call plug#begin('~/.vim/plugged')

" Code completion
" Plug 'valloric/youcompleteme', {'do': 'install.py --all'}
Plug 'raimondi/delimitmate'
" Plug 'tenfyzhong/completeparameter.vim'

" GUI Interface
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'

"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'

Plug 'myusuf3/numbers.vim'

" Syntax highlighting
Plug 'briancollins/vim-jst'
Plug 'pangloss/vim-javascript'
Plug 'Superbil/llvm.vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'neovimhaskell/haskell-vim'
" Don't use that cause it's out of date
" Plug 'https://github.com/jvoorhis/coq.vim'
Plug 'leafgarland/typescript-vim'

" Language processing
"Plug 'scrooloose/syntastic'
" TODO: check if this is actually needed in liu of coc?
"Plug 'Quramy/tsuquyomi'
"Plug 'xavierd/clang_complete'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Coq
Plug 'theKidOfArcrania/Coqtail'

" Haskell
" Plug 'alx741/vim-hindent' " Optional

" Other stuff
Plug 'tpope/vim-eunuch'
Plug 'terryma/vim-multiple-cursors'
Plug '~/.vimlocal/elflord2'
Plug '~/.vimlocal/unicode'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'fidian/hexmode'
Plug 'chrisbra/unicode.vim'
Plug 'qnighy/lalrpop.vim'
Plug 'rust-lang/rust.vim'
" Plug 'github/copilot.vim'

Plug 'NLKNguyen/papercolor-theme'

call plug#end()

colorscheme PaperColor
" set background=dark
let &background = substitute(system("system-theme"), "[\n\r ]", "", "")

set secure
