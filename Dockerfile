FROM testbed/vim:latest

RUN apk --no-cache add gtk+2.0-dev libx11-dev libxt-dev mcookie xauth xvfb
RUN install_vim -tag master --enable-gui=gtk2 --with-x -build
RUN ln -s /vim-build/bin/vim-master /usr/bin/gvim
RUN gvim --version

WORKDIR /vim-python-pep8-indent

ADD Gemfile .
RUN apk --no-cache add coreutils ruby-bundler
RUN bundle install

ADD . /vim-python-pep8-indent

ENTRYPOINT ["sh", "-c", "Xvfb :99 & DISPLAY=:99 rspec spec $@", "ignore"]
