# raylib-pas A Pascal Binding for Raylib 2.6.0-dev (master)

raylib-pas is a header translation of the Raylib Game Development Library for the FreePascal Project.

## Cross Platform (`make`)

You can execute `make` on GNU+Linux, macOS and Windows(TODO).

### Shared or Static Library

You will need to source [raylib](https://github.com/raysan5/raylib/) for your platform.

- [Working on GNU Linux](https://github.com/raysan5/raylib/wiki/Working-on-GNU-Linux)
- [Working on macOS](https://github.com/raysan5/raylib/wiki/Working-on-macOS)
- [Working on Windows](https://github.com/raysan5/raylib/wiki/Working-on-Windows)

We assume you linked or copied the `raylib` shared(`*.so,*.dylib,*.dll`) or static(`*.a`) library for your platform into `./bin`.

If you want to use the static library use `make` as follow:

```sh
make RAYLIB_LIBTYPE=STATIC
```

### GNU+Linux

If you use the shared library you must specify where to source the `libraylib.so` file.

```
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:. # adjust the export to search for the .so in the local path
```

## Examples

Try some of the ported c to fpc examples in `examples/core`, `examples/models`, `examples/audio` etc.

Thanks to drezgames/raylib-pascal for the examples. Originally delphi, now fpc.

## TODO

- Eventually we will be doing some work to compile the project with static linking. Hopefully this will allow for more cross-platform compilation of raylib-pas. Mainly for Android and eventually iOS when raylib supports that.
- Add Android and WebAssembly support.
- Port/Create more examples and games.
- Include Binary Distribution of "Supported" Raylib Shared Libraries with this binding.
