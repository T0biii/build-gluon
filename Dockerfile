FROM debian:stable-slim

# Set locale
ENV LANG C.UTF-8

# Make configure ignore root
ENV FORCE_UNSAFE_CONFIGURE 1

# Install needed packages
RUN apt-get update && apt-get install -y bzip2 gawk g++ gcc git libncurses5-dev libssl-dev make python unzip wget zip zlib1g-dev pkg-config cmake

# Fetch files from gluon repository
RUN git clone https://github.com/T0biii/site-ffm.git -b release-v2019.0.t0biii gluon

RUN git clone http://git.universe-factory.net/libuecc.git && cd libuecc && cmake ./ && make && make install && ldconfig && cd ../ && git clone https://github.com/freifunk-gluon/ecdsautils.git && cd ecdsautils && mkdir build && cd build/ && cmake ../ && make && make install && ldconfig
