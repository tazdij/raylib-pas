#/bin/sh
LIBS=./libs
BIN=./bin
TMP=./tmp
RAYLIB=$BIN/libraylib.dylib
PASFILES=./examples/**/*.pas
STATIC=false
DEBUG=

if test -f "$1"; then
    PASFILES=$1
fi

if [[ $@ == *'--static'* ]]
then
  STATIC=true
fi

if [[ $@ == *'--debug'* ]]
then
  DEBUG="-g -O1"
fi

for pasfile in $PASFILES
do
  if [ $STATIC = true ]
  then
fpc -k"-framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL  `pwd`/bin/libraylib.a" -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP $DEBUG $pasfile
  else
    fpc -k"$RAYLIB" -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP $DEBUG $pasfile
  fi
done
