# raylib-pas A Pascal Binding for Raylib 2.5.0

raylib-pas is a header translation of the Raylib Game Development Library. It is intended for use with a Shared Library (raylib.dll or raylib.so) From a FreePascal Project. Currently this comes with a 32bit raylib.dll file compiled with the MinGW GCC 8.1.0 32Bit.

Eventually I will be doing some work to compile the project with static linking. Hopefully this will allow for more cross-platform compilation of raylib-pas. Mainly for Android and eventually iOS when raylib supports that.

# Cross Platform Builds

You can execute `make` on Windows, GNU+Linux and macOS. (TODO Would <3 to add Android and WebAssembly support)

Atm we assume you linked or copied the `raylib` dynamic library for your platform into `./bin` eg.

- macOS: `brew install raylib && ln -s /usr/local/Cellar/raylib/2.5.0/lib/libraylib.dylib ./bin/libraylib.dylib` (if you use homebrew).
- GNU+Linux: [Download prebuilt binary release](https://github.com/raysan5/raylib/releases) `wget https://github.com/raysan5/raylib/releases/download/2.5.0/raylib-2.5.0-Linux-amd64.tar.gz && tar -xvf raylib-2.5.0-Linux-amd64.tar.gz raylib-2.5.0-Linux-amd64/lib/libraylib.so ./bin/libraylib.so`
- Windows: ???
