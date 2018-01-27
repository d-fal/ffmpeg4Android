#!/bin/bash

pushd .
cd ../x264

PLATFORM=$NDK/platforms/android-19/arch-x86
PREFIX=../ffmpeg-build/x86
TOOLCHAIN=$NDK/toolchains/x86-4.9/prebuilt/linux-x86_64
function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-pic \
  --host=i686-linux \
  --cross-prefix=$TOOLCHAIN/bin/i686-linux-android- \
  --sysroot=$PLATFORM

  make clean
  make
  make install
}

build_one

echo Android x86 builds finished

popd
