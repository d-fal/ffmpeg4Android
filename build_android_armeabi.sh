#!/bin/bash
#Change NDK to your Android NDK location
NDK=$HOME/Android/ndk
PLATFORM=$NDK/platforms/android-18/arch-arm/
PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=arm \
--cc=$PREBUILT/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/bin/arm-linux-androideabi- \
--nm=$PREBUILT/bin/arm-linux-androideabi-nm \
--extra-cflags="-I../ffmpeg-build/armeabi/include" \
--extra-ldflags="-L../ffmpeg-build/armeabi/lib" "


MODULES="\
--enable-gpl \
--enable-libx264"

function build_ARMv6
{
  ./configure \
  --target-os=android \
  --prefix=./android/armeabi \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --enable-shared \
  --disable-static \
  $COMMON_FLAGS \
  --extra-cflags=" -O3 -fpic -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300 -mfloat-abi=softfp -mfpu=vfp -marm -march=armv6" \
  --extra-ldflags="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  ${MODULES} \
  --disable-doc \
  --enable-neon

  make clean
  make
  make install
}



build_ARMv6

echo Android ARMEABI builds finished
