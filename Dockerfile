FROM debian:jessie

RUN groupadd -r rtorrent && useradd -r -g rtorrent rtorrent

RUN apt-get update && apt-get install -y rtorrent
