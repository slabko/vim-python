FROM ubuntu:18.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update && apt install -y \
   build-essential \
   cmake  \
   curl \
   git \
   libatk1.0-dev \
   liblua5.1-dev \
   libluajit-5.1 \
   libncurses5-dev \
   libperl-dev \
   libx11-dev \
   libxpm-dev \
   libxt-dev \
   luajit \
   python3 \
   python3-dev \
   python3-pip \
   ruby-dev && \
   apt clean && \
   rm -rf /var/lib/apt/lists/*

RUN pip3 install virtualenv flake8 mypy

RUN mkdir /usr/include/lua5.1/include && \
    cp /usr/include/lua5.1/*.h /usr/include/lua5.1/include/

RUN cd root && \
    mkdir /root/opt && \
    cd /root/opt && \
    git clone https://github.com/vim/vim && \
    cd /root/opt/vim && \
    ./configure \
       --with-features=huge \
       --enable-multibyte \
       --enable-rubyinterp=yes \
       --enable-python3interp=yes \
       --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \
       --enable-perlinterp=yes \
       --enable-luainterp=yes \
       --with-luajit \
       --with-lua-prefix=/usr/include/lua5.1 \
       --enable-gui=gtk2 \
       --enable-cscope \
       --prefix=/usr/local && \ 
    make &&  make install && make clean && \
    cd  /root && \
    rm -rf opt

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
    git clone https://github.com/tpope/vim-fugitive.git && \
    git clone https://github.com/wincent/terminus.git


COPY vimrc /root/.vimrc

# https://vi.stackexchange.com/questions/5110/quickfix-support-for-python-tracebacks
COPY vim/compiler/python.vim /root/.vim/compiler/python.vim
COPY vim/after/ftplugin/python.vim /root/.vim/after/ftplugin/python.vim

WORKDIR /root
