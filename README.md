# vim-python
Docker container with vim and python support to run on remote machines

Notes:
- It only works with `virtualenv`; `venv` doesn't seem to work.
- F6 runs systax check, type check and linter.
- `flake8` and `mypy` should be installed to enable type checks and linter.
- `<leader>` is mapped to `" "` i.e. the space key.
- Go to definition `<leader> pd`.
- Get docs `<leader> pb`.
- Get type `<leader> pv`.
- Get GIT status `<leader> gs`.
- Get diff of a file `<leader> gd`.
- Open file in NERDTree `<leader> nr`.


Spelunker
- `Zl` correct word under the cursor
- `Zg` add word to spellfile
- `ZN` and `ZP` jump to next and previus misspeled word


IPython
- `<leader>js` - start IPython in the tmux window on the right
- `<leader>jq` - exit IPython
- `<leader>jQ` - restart IPython
- `<leader>jr` - run cell and jump to the next
- `<leader>jR` - run notebook
- `<leader>jl` - clear the notebook

- `<leader>jj` and `<leader>jk` - go to next/prev cell
- `<leader>jh` send current line or selection to IPython
- `<leader>jp` run the previous command
