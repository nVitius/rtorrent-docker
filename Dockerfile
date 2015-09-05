FROM debian:jessie

WORKDIR /tmp

RUN groupadd -r rtorrent && useradd -r -d /config -g rtorrent rtorrent

RUN apt-get update && apt-get install -y curl build-essential automake nginx \
    libtool libcppunit-dev libcurl3-dev libcurl3-openssl-dev libssl-dev libsigc++-2.0-dev `# libtorrent deps` \
    libncurses-dev `# rtorrent deps`

RUN curl -L https://github.com/rakshasa/libtorrent/archive/0.13.6.tar.gz | tar -zx && \
    cd libtorrent-0.13.6 && \
    ./autogen.sh && ./configure && make && make install && \
    rm -rf /tmp/libtorrent-0.13.6

RUN curl -L http://downloads.sourceforge.net/project/xmlrpc-c/Xmlrpc-c%20Super%20Stable/1.33.17/xmlrpc-c-1.33.17.tgz | tar -zx && \
    cd xmlrpc-c-1.33.17 && \
    ./configure --disable-cplusplus && make && make install && \
    rm -rf /tmp/xmlrpc-c-1.33.17

RUN curl -L https://github.com/rakshasa/rtorrent/archive/0.9.6.tar.gz | tar -zx && \
    cd rtorrent-0.9.6 && \
    ./autogen.sh && ./configure --with-xmlrpc-c && make && make install && \
    ldconfig && \
    rm -rf /tmp/rtorrent-0.9.6

USER rtorrent

VOLUME /downloads
VOLUME /config

EXPOSE 5000

COPY rtorrent.rc.default /config/
