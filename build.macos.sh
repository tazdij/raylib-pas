#/bin/sh
LIBS=./libs
BIN=./bin
TMP=./tmp
RAYLIB=$BIN/libraylib.dylib

STATIC=false
if [[ $@ == *'--static'* ]]
then
  echo "building using static .a"
  STATIC=true
fi

for pasfile in ./examples/**/*.pas
do
  if [ $STATIC = true ]
  then
fpc -k"-framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL  `pwd`/bin/libraylib.a" -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP $pasfile
  else
    fpc -k"$RAYLIB" -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP $pasfile
  fi
done
