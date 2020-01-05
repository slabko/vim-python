FROM ubuntu:18.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update && apt install -y \
   build-essential \
   cmake \
   curl \
   git \
   python3-pip \
   vim && \
   apt clean && \
   rm -rf /var/lib/apt/lists/*

RUN pip3 install flake8 mypy virtualenv

# == Pathogen.vim ==
RUN mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

WORKDIR /root/.vim/bundle

# == YouCompleteMe ==
RUN git clone https://github.com/ycm-core/YouCompleteMe.git && \
    cd /root/.vim/bundle/YouCompleteMe && \
    git submodule update --init --recursive && \
    python3 ./install.py --clang-completer && \
    cd /root/.vim/bundle

# == Other plugins ==
RUN git clone https://github.com/vim-scripts/indentpython.vim.git && \
    git clone https://github.com/vim-syntastic/syntastic.git && \
    git clone https://github.com/kien/ctrlp.vim.git && \
    git clone https://github.com/scrooloose/nerdtree.git && \
    git clone https://github.com/tmhedberg/SimpylFold.git && \
    git clone https://github.com/tpope/vim-surround.git && \
    git clone https://github.com/tpope/vim-fugitive.git


COPY vimrc /root/.vimrc

# https://vi.stackexchange.com/questions/5110/quickfix-support-for-python-tracebacks
COPY vim/compiler/python.vim /root/.vim/compiler/python.vim
COPY vim/after/ftplugin/python.vim /root/.vim/after/ftplugin/python.vim

WORKDIR /root
