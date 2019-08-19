execute pathogen#infect()

syntax on
filetype plugin indent on


set clipboard=unnamedplus
set encoding=utf-8
set nu

let mapleader=" "

" PEP 8 indentation
au BufNewFile,BufRead *.py set 
  \ tabstop=4
  \ softtabstop=4
  \ shiftwidth=4
  \ textwidth=79
  \ expandtab
  \ autoindent
  \ fileformat=unix


" Enable folding
set foldmethod=indent
set foldlevel=99


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


" == YouCompleteMe =====================================================
let g:ycm_autoclose_preview_window_after_completion = 1 
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

map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>b  :YcmCompleter GetDoc<CR>
map <leader>v  :YcmCompleter GetType<CR>

" == CtrlP =============================================================
let g:ctrlp_custom_ignore = 'node_modules\|\.venv'
let g:ctrlp_working_path_mode = 'c'
" default 'ra'
" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one 
"       of these directories or files: .git .hg .svn .bzr
" 'a' - like c, but only if the current working directory 
"       outside of CtrlP is not a direct ancestor of the directory 
"       of the current file.
