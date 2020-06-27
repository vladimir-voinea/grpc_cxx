FROM alpine:3.12

RUN apk update && \
    apk upgrade && \
    apk add --no-cache linux-headers g++ build-base cmake bash openssl-dev libstdc++ git && \
    rm -rf /var/cache/apk/* 

RUN git clone --recurse-submodules -b v1.30.0 https://github.com/grpc/grpc && cd grpc && \
    git submodule update --init && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DgRPC_SSL_PROVIDER=package ../.. && \
    make -j`nproc` && \
    make install && \
    cd ../.. && rm -rf /grpc

CMD [ "/bin/sh" ]
