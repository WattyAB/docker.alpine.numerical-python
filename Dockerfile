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
# RUN mkdir -p ~/src
# RUN cd ~/src/ && mv /tmp/lapack.tgz .
# RUN cd ~/src/ && tar xzf lapack.tgz
# RUN cp /tmp/make.inc ~/src/lapack-3.5.0/make.inc
# RUN cd ~/src/lapack-3.5.0/ && make lapacklib
# RUN cd ~/src/lapack-3.5.0/ && make clean
RUN sh /tmp/lapack.sh
RUN export LAPACK=~/src/lapack-3.5.0/liblapack.a


# REQUIREMENTS
RUN pip install numpy==1.9.2
RUN pip install matplotlib==1.4.3
RUN pip install scipy==0.16.0
RUN pip install seaborn==0.6.0
RUN pip install ipython[all]
RUN pip install -r /tmp/requirements.txt
