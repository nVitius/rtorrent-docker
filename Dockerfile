FROM debian:jessie

RUN groupadd -r rtorrent && useradd -r -g rtorrent rtorrent

RUN apt-get update && apt-get install -y curl build-essential automake \
    libtool libcppunit-dev libcurl3-dev libcurl3-openssl-dev libssl-dev libsigc++-2.0-dev `# libtorrent deps`

RUN curl -L https://github.com/rakshasa/libtorrent/archive/0.13.4.tar.gz | tar -zx && \
    cd libtorrent-0.13.4 && \
    ./autogen.sh && ./configure && make && make install
