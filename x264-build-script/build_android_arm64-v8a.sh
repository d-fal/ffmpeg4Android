#!/bin/bash

pushd .

cd ../x264
PLATFORM=$NDK/platforms/android-21/arch-arm64/
PREFIX=../ffmpeg-build/armeabi-v8a
TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64
function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-pic \
  --host=aarch64-linux \
  --cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
  --sysroot=$PLATFORM

  make clean
  make
  make install
}

build_one

echo Android ARM64 builds finished

popd
