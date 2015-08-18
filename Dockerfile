FROM alpine
MAINTAINER CAtholabs <catholabs@catho.com>
WORKDIR /tmp/

COPY requirements.txt /tmp/
COPY make.inc /tmp/
COPY lapack.tgz /tmp/
COPY blas.tgz /tmp/
COPY blas.sh /tmp/
COPY lapack.sh /tmp/

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
# RUN mkdir -p ~/src/
# RUN cd ~/src/
# RUN mv /tmp/blas.tgz .
# RUN tar xzf blas.tgz
# RUN cd BLAS
# RUN gfortran -O3 -std=legacy -m64 -fno-second-underscore -fPIC -c *.f
# RUN ar r libfblas.a *.o
# RUN ranlib libfblas.a
# RUN rm -rf *.o
RUN sh /tmp/blas.sh
RUN export BLAS=~/src/BLAS/libfblas.a


# LAPACK
RUN mkdir -p ~/src
RUN cd ~/src/ && mv /tmp/lapack.tgz .
RUN cd ~/src/ && tar xzf lapack.tgz
RUN cd ~/src/ && cd lapack-*/
RUN cd ~/src/ && cp /tmp/make.inc .
RUN cd ~/src/ && make lapacklib
RUN cd ~/src/ && make clean
RUN cd ~/src/ && sh /tmp/lapack.sh
RUN cd ~/src/ && export LAPACK=~/src/lapack-3.5.0/liblapack.a


# REQUIREMENTS
RUN pip install -r /tmp/requirements.txt
