# raylib-pas A Pascal Binding for Raylib 2.5.0

raylib-pas is a header translation of the Raylib Game Development Library. It is intended for use with a Shared Library (`raylib.dll`, `libraylib.so`, `libraylib.dylib`) From a FreePascal Project.

## Cross Platform (`make`)

You can execute `make` on Windows, GNU+Linux and macOS.

We assume you linked or copied the `raylib` shared library for your platform into `./bin` eg.

#### GNU+Linux

- [Download prebuilt binary release for your distro](https://github.com/raysan5/raylib/releases) 

```sh
wget https://github.com/raysan5/raylib/releases/download/2.5.0/raylib-2.5.0-Linux-amd64.tar.gz
tar -xvf raylib-2.5.0-Linux-amd64.tar.gz raylib-2.5.0-Linux-amd64/lib/*.so ./bin/`
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:. # adjust the export to search for the .so in the local path
```

#### macOS

- Note you can also source the latest binary release from github as in the GNU+Linux step, or use the Homebrew package:

```sh
brew install raylib
ln -s /usr/local/Cellar/raylib/2.5.0/lib/libraylib.dylib ./bin/libraylib.dylib
```

#### Windows

- Currently tested with a 32bit raylib.dll file compiled with the MinGW GCC 8.1.0 32Bit.
- [Download prebuilt binary release for your Windows (eg `Win<64/32>-<mingw/msvc15>.zip`)](https://github.com/raysan5/raylib/releases)
- Copy the dll to `./bin`.

## Examples

Try some of the ported c to fpc examples in `examples/core`, `examples/models`, `examples/audio` etc.

Thanks to drezgames/raylib-pascal for the examples. Ported by raylib-pas from delphi to fpc.

## TODO

- Eventually I will be doing some work to compile the project with static linking. Hopefully this will allow for more cross-platform compilation of raylib-pas. Mainly for Android and eventually iOS when raylib supports that.

- Add Android and WebAssembly support.

- Port/Create more examples and games.
