# More complex web version that allows to use vcpkg
FROM stateoftheartio/qt6:6.6-wasm-aqt

WORKDIR /home/user

# Install vcpkg
USER root
RUN apt update && apt install curl zip unzip tar pkg-config -y
USER user
RUN git clone --depth 1 https://github.com/microsoft/vcpkg /home/user/vcpkg && /home/user/vcpkg/bootstrap-vcpkg.sh
ENV PATH=$PATH:/home/user/vcpkg

# Install zlib dep
RUN CC=emcc CXX=em++ vcpkg install --triplet=wasm32-emscripten zlib

COPY . .

RUN cmake \
    -DCMAKE_TOOLCHAIN_FILE=/home/user/vcpkg/scripts/buildsystems/vcpkg.cmake \
    -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=$QT_WASM/lib/cmake/Qt6/qt.toolchain.cmake \
    -DQT_HOST_PATH=$(dirname "$QT_WASM")/gcc_64 \
    -B build -G Ninja
RUN cmake --build build -j 4


FROM scratch
COPY --from=0 [ \
    "/home/user/build/QT6HW.js", \
    "/home/user/build/QT6HW.html", \
    "/home/user/build/QT6HW.wasm", \
    "/home/user/build/qtloader.js", \
    "." \
]
