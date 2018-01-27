#!/bin/bash

pushd .
cd ../x264



PLATFORM=$NDK/platforms/android-18/arch-arm
PREFIX=../ffmpeg-build/armeabi
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt
function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-pic \
  --host=arm-linux \
  --cross-prefix=$TOOLCHAIN/linux-x86_64/bin/arm-linux-androideabi- \
  --sysroot=$PLATFORM

  make clean
  make
  make install
}

build_one

echo Android ARM builds finished
popd 
