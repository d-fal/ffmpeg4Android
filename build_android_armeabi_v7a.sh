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
--nm=$PREBUILT/bin/arm-linux-androideabi-nm"


MODULES="\
--enable-gpl \
--enable-libx264"

function build_ARMv7
{
  ./configure \
  --target-os=android \
  --prefix=./android/armeabi-v7a \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --enable-shared \
  --disable-static \
  $COMMON_FLAGS \
  --extra-cflags="-DANDROID -fPIC -I$HOME/work/FFMPEG/ffmpeg-build/armeabi-v7a/include -ffunction-sections -funwind-tables -fstack-protector -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300" \
  --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$HOME/work/FFMPEG/ffmpeg-build/armeabi-v7a/lib -lx264 -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog " \
  --enable-zlib \
  ${MODULES} \
  --disable-doc \
  --enable-neon \
  --disable-avdevice \
  --enable-encoder=libx264

  make clean
  make
  make install
}

build_ARMv7
echo Android ARMv7-a builds finished
