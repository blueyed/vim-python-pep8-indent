FROM ruby:2.4.1-slim
RUN sed s/^deb/deb-src/ /etc/apt/sources.list > /etc/apt/sources.list.d/deb-src.list
RUN apt-get update && \
    apt-get install -y curl xvfb && \
    apt-get build-dep -y vim && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /vim-python-pep8-indent

RUN curl -L https://github.com/vim/vim/archive/master.tar.gz | tar xzf - && \
  cd vim-master && \
  ./configure && make && make install && \
  cd .. && rm -rf vim-master

ADD Gemfile .
RUN bundle install
ADD . /vim-python-pep8-indent

RUN vim --version

ENTRYPOINT ["sh", "-c", "xvfb-run rspec spec -f doc $@", "ignore"]
