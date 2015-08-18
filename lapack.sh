#!/usr/bin/env bash
mkdir -p ~/src/
cd ~/src/
RUN mv /tmp/lapack.tgz .
RUN tar xzf lapack.tgz
RUN cd lapack-*/
RUN cp /tmp/make.inc .
RUN make lapacklib
RUN make clean
RUN export LAPACK=~/src/lapack-3.5.0/liblapack.a
