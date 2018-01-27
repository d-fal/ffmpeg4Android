<h2>This is a painless ffmpeg building with libx264 support.</h2>

<h3>Before you start</h3>

get all the prject files and submodules 

<em>git clone --recursive https://github.com/falahati1987/ffmpeg4Android</em>

<br>
cd to the clonned project:
cd ffmpeg4Android

open buid_ffmpeg_for_android.sh in a editor and edit the following function in line 6, so as to it target to your NDK

getNDK(){<br>
    echo "$HOME/Android/ndk" #root to your NDK <br>
}<br>

Now, all you need to do is :<br>

./build_ffmpeg_for_android.sh

The shared libraries will be placed in build-ffmpeg folder.

Enjoy!
