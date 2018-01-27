#!/usr/bin/env bash

chmod a+x build_ffmpeg_for_android.sh

getNDK(){
    echo "/home/dfalahati/Android/ndk" #root to your NDK
}
export NDK="$(getNDK)";

pushd .

echo "Building x264 for android"
cd x264-build-script
./build_android_all.sh

popd

pushd .

cd ffmpeg-build-script
./build_android_all.sh

popd

echo "Building finished. You can find your compiled libraries in ffmpeg-build\n"
