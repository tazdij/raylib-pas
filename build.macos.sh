#/bin/sh
LIBS=./libs
BIN=./bin
TMP=./tmp
RAYLIB=$BIN/libraylib.dylib

fpc -k"$RAYLIB" -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP ./src/animation_test.pas
fpc -k"$RAYLIB" -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP ./examples/core/*.pas
