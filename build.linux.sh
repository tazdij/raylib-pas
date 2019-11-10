#/bin/sh
LIBS=./libs
BIN=./bin
TMP=./tmp
RAYLIB=$BIN

fpc -Fl$RAYLIB -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP ./src/animation_test.pas
fpc -Fl$RAYLIB -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP ./examples/core/*.pas
