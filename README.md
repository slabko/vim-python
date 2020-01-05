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
