# Just for consistency in the build process, no effect on the output.
ARG BUILD_DIR=build
ARG OUTPUT_DIR=out

FROM alpine:latest AS build

RUN apk add --no-cache cmake g++ g++-arm-none-eabi git linux-headers make newlib-arm-none-eabi python3

ARG PICO_SDK_VERSION=2.3.1
RUN git clone --branch ${PICO_SDK_VERSION} --recursive -j8 https://github.com/raspberrypi/pico-sdk.git
ENV PICO_SDK_PATH=/pico-sdk

# Copying this file, as the build fails with "cmake -E touch_nocreate: failed to update "//CMakeLists.txt"." if it's bind mounted.
COPY CMakeLists.txt .
ARG BUILD_DIR
ARG OUTPUT_DIR
ARG BUILD_TYPE=Release
RUN \
  --mount=type=cache,target=${BUILD_DIR} \
  --mount=type=bind,source=src,target=src,readonly \
  --mount=type=bind,source=pico_sdk_import.cmake,target=pico_sdk_import.cmake,readonly \
  cmake -B ${BUILD_DIR} -DCMAKE_BUILD_TYPE=${BUILD_TYPE} && \
  cmake --build ${BUILD_DIR} && \
  mkdir ${OUTPUT_DIR} && \
  cp ${BUILD_DIR}/src/*.uf2 ${OUTPUT_DIR}
  # Adjust the line above to copy the desired files to the output directory.

FROM scratch

ARG OUTPUT_DIR
COPY --from=build ${OUTPUT_DIR} .
