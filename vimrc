execute pathogen#infect()

syntax on
filetype plugin indent on

" Change cursor in insert mode
" https://stackoverflow.com/questions/6488683/how-do-i-change-the-vim-cursor-in-insert-normal-mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END


" Remove delay after pressing ESC
" https://www.reddit.com/r/vim/comments/2391u5/delay_while_using_esc_to_exit_insert_mode/
set ttimeout
set ttimeoutlen=100
set timeoutlen=3000

" Disable autowrap in insert mode
set formatoptions-=t

" Share clipboard and the default register 
set clipboard=unnamedplus

set encoding=utf-8
set nu

let mapleader=" "

" Status Line
set laststatus=2
set statusline=%f

" PEP 8 indentation
au BufNewFile,BufRead *.py set 
  \ tabstop=4
  \ softtabstop=4
  \ shiftwidth=4
  \ textwidth=79
  \ expandtab
  \ autoindent
  \ fileformat=unix
  \ foldmethod=indent

" Yaml indentation
au BufNewFile,BufRead *.{yaml,yml} set 
  \ tabstop=2
  \ softtabstop=2
  \ shiftwidth=2
  \ expandtab
  \ autoindent
  \ foldmethod=indent

" LaTeX indentation
au BufNewFile,BufRead *.{tex} set 
  \ tabstop=4
  \ softtabstop=4
  \ shiftwidth=4
  \ expandtab
  \ autoindent
  \ foldmethod=indent
  \ indentexpr=

au BufNewFile,BufRead *.{ts,js} set 
  \ tabstop=2
  \ softtabstop=2
  \ shiftwidth=2
  \ expandtab
  \ autoindent
  \ foldmethod=indent

au BufNewFile,BufRead *.{go} set 
  \ tabstop=4
  \ softtabstop=4
  \ shiftwidth=4
  \ expandtab
  \ autoindent
  \ foldmethod=indent

" Do not fold automatically
set foldlevel=99


" Ignore some files and folders
set wildignore+=node_modules/**,.git/**,.venv/**,__pycache__/**,*.pyc

" == Syntastic =========================================================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = {'mode':'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['mypy', 'flake8']

nnoremap <F6> :w<CR> :SyntasticCheck<CR>


" == SimpylFold ========================================================
let g:SimpylFold_docstring_preview=1


" == NERDTree ==========================================================
"autocmd vimenter * NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

map <C-n> :NERDTreeToggle<CR>
map <leader>nr :NERDTreeFind<CR>

" == YouCompleteMe =====================================================
let g:ycm_autoclose_preview_window_after_completion = 1 
let g:ycm_auto_hover = 'none'
let g:ycm_semantic_triggers = {
\   'python': [
\      're!import\s',
\      're!from\s',
\      're!from\s+\S+\s+import\s(\S+,\s)+'
\   ]
\}

" Python with virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  with open(activate_this) as fp:
     context = fp.read()
  exec(context, dict(__file__=activate_this))
EOF

" Show type in YCM's hovers
augroup MyYCMCustom
autocmd!
autocmd FileType python let b:ycm_hover = {
\ 'command': 'GetType',
\ 'syntax': &filetype
\ }
augroup END

map <leader>pd  :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>pb  :YcmCompleter GetDoc<CR>
map <leader>pr  :YcmCompleter GoToReferences<CR>
" map <leader>pv  <plug>(YCMHover)
map <leader>pv  :YcmCompleter GetType<CR>

map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
map <F5> :%s/\<<C-r><C-w>\>/

" == CtrlP =============================================================
let g:ctrlp_custom_ignore = 'node_modules\|\.venv\|__pycache__\|\.pyc'
let g:ctrlp_working_path_mode = ''

" == fugitive.vim ======================================================
map <leader>gs  :Gstatus <bar> resize 15 <CR>
map <leader>gd  :Gdiff<CR>

" == vim-test ==========================================================
let test#strategy = "dispatch"

let g:dispatch_compilers = {
\ 'pytest': 'pytest',
\}

let test#python#pytest#options = ' --tb=short -q'

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" == slime =============================================================
let g:slime_target = "neovim"
let g:slime_python_ipython = 1
let g:slime_default_config = {'jobid': 4}
let g:slime_dont_ask_default = 1

" let g:slime_vimterminal_cmd = "/bin/bash"


" let g:slime_default_config = {
"             \ 'socket_name': get(split($TMUX, ','), 0),
"             \ 'target_pane': '{top-right}' }
" let g:slime_dont_ask_default = 1

nnoremap <Leader>js :vsplit term://bash<CR> <C-w>L :SlimeSend1 ipython --matplotlib<CR> <C-w>h
nnoremap <Leader>jq :SlimeSend1 exit<CR>
nnoremap <Leader>jQ :IPythonCellRestart<CR>
nnoremap <Leader>jr :IPythonCellExecuteCellJump<CR>
nnoremap <Leader>jR :IPythonCellRun<CR>
nnoremap <Leader>jl :IPythonCellClear<CR>

nnoremap <Leader>jx :IPythonCellClose<CR>

nnoremap <Leader>jk :IPythonCellPrevCell<CR>
nnoremap <Leader>jj :IPythonCellNextCell<CR>

" map <Leader>h to send the current line or current selection to IPython
nmap <Leader>jh <Plug>SlimeLineSend
xmap <Leader>jh <Plug>SlimeRegionSend

" map <Leader>p to run the previous command
nnoremap <Leader>jp :IPythonCellPrevCommand<CR>
