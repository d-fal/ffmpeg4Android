#!/bin/bash
#Change NDK to your Android NDK location

pushd .
cd ../ffmpeg
PLATFORM=$NDK/platforms/android-21/arch-arm64/
PREBUILT=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--arch=aarch64 \
--cc=$PREBUILT/bin/aarch64-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/aarch64-linux-android- \
--nm=$PREBUILT/bin/aarch64-linux-android-nm \
--extra-cflags="-I../ffmpeg-build/armeabi-v8a/include" \
--extra-ldflags="-L../ffmpeg-build/armeabi-v8a/lib" "

MODULES="\
--enable-gpl \
--enable-libx264"



function build_arm64
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=android \
  --prefix=$PREFIX/armeabi-v8a \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags="" \
  $COMMON_FLAGS \
  --extra-ldflags="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-shared \
  --disable-static \
  --disable-doc \
  --enable-zlib \
  ${MODULES}

  make clean
  make
  make install
}

build_arm64


echo Android ARM64v8a builds finished

popd
