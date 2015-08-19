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
    ncurses \
    readline \
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
ENV BLAS=~/src/BLAS/libfblas.a


# LAPACK
# RUN mkdir -p ~/src
# RUN cd ~/src/ && mv /tmp/lapack.tgz .
# RUN cd ~/src/ && tar xzf lapack.tgz
# RUN cp /tmp/make.inc ~/src/lapack-3.5.0/make.inc
# RUN cd ~/src/lapack-3.5.0/ && make lapacklib
# RUN cd ~/src/lapack-3.5.0/ && make clean
RUN sh /tmp/lapack.sh
ENV LAPACK=~/src/lapack-3.5.0/liblapack.a


# REQUIREMENTS
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install numpy==1.9.2
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install matplotlib==1.4.3
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install scipy==0.16.0
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install seaborn==0.6.0
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install ipython[all]
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install -r /tmp/requirements.txt
