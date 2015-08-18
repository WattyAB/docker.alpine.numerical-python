FROM alpine
MAINTAINER CAtholabs <catholabs@catho.com>
WORKDIR /tmp

COPY requirements.txt /tmp/
COPY make.inc /tmp/
COPY lapack.tgz /tmp/
COPY blas.tgz /tmp/

# System packages
RUN apk update && apk add \
    gcc \
    python \
    py-pip \
    libjpeg \
    zlib \
    zlib-dev \
    tiff \
    freetype \
    git \
    py-pillow \
    python-dev \
    musl-dev \
    bash \
    mysql-client \
    gfortran \
    gsl \
    mariadb-libs \
    libxft-dev \
    pkgconfig \
    pkgconf \
    python-dev \
    tmux \
    curl \
    nano \
    vim \
    htop \
    man \
    unzip \
    wget \
    g++ \
    mariadb-dev \
    libgfortran \
    make


# BLAS
RUN mkdir -p ~/src/
RUN cd ~/src/
RUN mv /tmp/blas.tgz .
RUN tar xzf blas.tgz
RUN cd BLAS
RUN gfortran -O3 -std=legacy -m64 -fno-second-underscore -fPIC -c *.f
RUN ar r libfblas.a *.o
RUN ranlib libfblas.a
RUN rm -rf *.o
RUN export BLAS=~/src/BLAS/libfblas.a


# LAPACK
RUN mkdir -p ~/src
RUN cd ~/src/
RUN mv /tmp/lapack.tgz .
RUN tar xzf lapack.tgz
RUN cd lapack-*/
RUN cp /tmp/make.inc .
RUN make lapacklib
RUN make clean
RUN export LAPACK=~/src/lapack-3.5.0/liblapack.a


# REQUIREMENTS
RUN pip install -r /tmp/requirements.txt