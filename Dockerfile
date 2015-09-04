FROM debian:jessie

RUN groupadd -r rtorrent && useradd -r -g rtorrent rtorrent

RUN apt-get update && apt-get install -y curl

RUN curl -o libtorrent.tar.gz https://github.com/rakshasa/libtorrent/archive/0.13.4.tar.gz &&
    tar -zxvf libtorrent
