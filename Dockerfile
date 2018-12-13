FROM debian:stretch

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils \
 && DEBIAN_FRONTEND=noninteractive dpkg-reconfigure apt-utils \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        automake \
        cmake \
        curl \
        wget \
        fakeroot \
        g++ \
        git \
        make \
        runit \
        sudo \
        xz-utils \
        rsync \
        gettext

RUN sudo apt-get update &&\
        DEBIAN_FRONTEND=noninteractive apt-get install -y vim \
        openjdk-8-jre \
        libtool \
        autoconf \
        unzip \
        pkg-config \
        patch \
        libglib2.0-dev \
        zlib1g \
        zlib1g-dev \
        flex \
        bison \
        bzip2

# Here is where we hardcode the toolchain decision.
ENV HOST=arm-rpi-linux-gnueabihf \
    TOOLCHAIN=gcc-linaro-arm-linux-gnueabihf-raspbian-x64 \
    RPXC_ROOT=/rpxc

WORKDIR $RPXC_ROOT
#RUN curl -L https://github.com/raspberrypi/tools/tarball/master \
#  | tar --wildcards --strip-components 3 -xzf - "*/arm-bcm2708/$TOOLCHAIN/"

RUN curl -L https://github.com/rvagg/rpi-newer-crosstools/tarball/master \
  |  tar --wildcards --strip-components 3 -xzf - "*/x64-gcc-6.3.1/arm-rpi-linux-gnueabihf/"



ENV ARCH=arm \
    CROSS_COMPILE=$RPXC_ROOT/bin/$HOST- \
    PATH=$RPXC_ROOT/bin:$PATH \
    SYSROOT=$RPXC_ROOT/sysroot


COPY image/ /


WORKDIR /build
ENTRYPOINT [ "/rpxc/entrypoint.sh" ]
