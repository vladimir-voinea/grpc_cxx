FROM ubuntu:20.10
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt install -yy -q --no-install-recommends \
        ca-certificates libssl-dev git build-essential autoconf libtool pkg-config cmake libtool curl make g++ unzip \
        && rm -rf /var/lib/apt/lists/*

RUN git clone --recurse-submodules -b v1.30.0 https://github.com/grpc/grpc && cd grpc && \
    git submodule update --init && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DgRPC_SSL_PROVIDER=package ../.. && \
    make -j`nproc` && \
    make install && \
    cd ../.. && rm -rf /grpc

CMD [ "/bin/sh" ]
