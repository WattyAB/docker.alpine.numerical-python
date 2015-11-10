FROM alpine:3.2

RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN echo "http://nl.alpinelinux.org/alpine/v3.2/main" > /etc/apk/repositories

COPY libs/* /tmp/

RUN apk update &&\
    apk add python \
            python-dev \
            py-pip \
            openntpd \
            build-base \
            python-dev \
            musl-dev \
            gfortran \
            libgfortran

# Build BLAS and LAPACK
RUN source /tmp/blas.sh
RUN source /tmp/lapack.sh

# Install numpy and pandas
RUN pip install --upgrade pip
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install -v numpy==1.9.0
RUN BLAS=~/src/BLAS/libfblas.a LAPACK=~/src/lapack-3.5.0/liblapack.a pip install -v pandas==0.14.1

# Clean up
RUN mv ~/src/BLAS/libfblas.a /tmp/
RUN mv ~/src/lapack-3.5.0/liblapack.a /tmp/
RUN rm -rf ~/src
RUN rm -rf ~/.cache/pip
RUN mkdir -p ~/src/BLAS ~/src/lapack-3.5.0
RUN mv /tmp/libfblas.a ~/src/BLAS/libfblas.a
RUN mv /tmp/liblapack.a ~/src/lapack-3.5.0/liblapack.a
RUN rm -rf /tmp/*

# Remove all the extra build stuff
RUN apk del build-base "*-dev"


