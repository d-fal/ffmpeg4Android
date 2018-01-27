#!/bin/bash

pushd .

cd ../x264
PLATFORM=$NDK/platforms/android-19/arch-mips/
PREFIX=../ffmpeg-build/mips
TOOLCHAIN=$NDK/toolchains/mipsel-linux-android-4.9/prebuilt/linux-x86_64
function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-pic \
  --host=mipsel-linux \
  --cross-prefix=$TOOLCHAIN/bin/mipsel-linux-android- \
  --sysroot=$PLATFORM \
  --disable-asm

  make clean
  make
  make install
}

build_one

echo Android MIPS builds finished

popd
