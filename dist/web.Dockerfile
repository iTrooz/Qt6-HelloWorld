FROM stateoftheartio/qt6:6.6-wasm-aqt

WORKDIR /home/user

COPY . .

RUN qt-cmake -B build -G Ninja
RUN cmake --build build -j 4


FROM scratch
COPY --from=0 [ \
    "/home/user/build/QT6HW.js", \
    "/home/user/build/QT6HW.html", \
    "/home/user/build/QT6HW.wasm", \
    "/home/user/build/qtloader.js", \
    "." \
]
