#!/bin/bash
#Change NDK to your Android NDK location
NDK=$HOME/Android/ndk
PLATFORM=$NDK/platforms/android-18/arch-x86/
PREBUILT=$NDK/toolchains/x86-4.9/prebuilt/linux-x86_64
PATH_X264=../x264


GENERAL="\
--enable-small \
--enable-cross-compile \
--extra-libs="-lgcc" \
--cc=$PREBUILT/bin/i686-linux-android-gcc \
--cross-prefix=$PREBUILT/bin/i686-linux-android- \
--nm=$PREBUILT/bin/i686-linux-android-nm \
--extra-cflags="-I../ffmpeg-build/x86/include" \
--extra-ldflags="-L../ffmpeg-build/x86/lib""

MODULES="\
--enable-gpl \
--enable-libx264"


function build_x86
{
  ./configure \
  --logfile=conflog.txt \
  --target-os=android \
  --prefix=$PREFIX/x86 \
  --arch=x86 \
  ${GENERAL} \
  --sysroot=$PLATFORM \
  --extra-cflags=" -O3 -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -fomit-frame-pointer -march=k8" \
  --enable-shared \
  --disable-static \
  $COMMON_FLAGS \
  --extra-cflags="-march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32" \
  --extra-ldflags="-lx264 -Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  --disable-doc \
  ${MODULES}

  make clean
  make
  make install
}

build_x86


echo Android X86 builds finished
