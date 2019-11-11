#/bin/sh
LIBS=./libs
BIN=./bin
TMP=./tmp
RAYLIB=$BIN/libraylib.dylib

fpc -k"$RAYLIB" -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP ./src/animation_test.pas
for pasfile in ./examples/**/*.pas
do
  fpc -k"$RAYLIB" -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP $pasfile
done
