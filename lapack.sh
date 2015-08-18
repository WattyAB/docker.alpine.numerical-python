#!/usr/bin/env bash
mkdir -p ~/src/
cd ~/src/
mv /tmp/lapack.tgz .
tar xzf lapack.tgz
cd lapack-3.5.0/
cp /tmp/make.inc .
make lapacklib
make clean
export LAPACK=~/src/lapack-3.5.0/liblapack.a
