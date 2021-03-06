from ubuntu:20.04
env DEBIAN_FRONTEND noninteractive
RUN apt update
run apt install -y cmake build-essential
run apt install -y git
run git clone --depth=1 -b v1.34.0 https://github.com/grpc/grpc.git
run cd grpc && git submodule update --init --depth=1
run cd /tmp && apt install -y curl && curl -O https://www.openssl.org/source/openssl-1.1.1i.tar.gz && \
    tar xzf openssl-1.1.1i.tar.gz && cd openssl-1.1.1i && \
    ./config && make -j16 && make install_sw && rm -rf /tmp/openssl-*
run cd grpc && cmake . -DBUILD_SHARED_LIBS=ON && make -j16 install
