#/bin/sh
LIBS=./libs
BIN=./bin
TMP=./tmp
RAYLIB=$BIN

STATIC=false # SHARED by default
if [[ $@ == *'--static'* ]]
then
  STATIC=true
fi

for pasfile in ./examples/**/*.pas
do
  if [ $STATIC = true ]
  then
    # https://github.com/glfw/glfw/issues/1517 Note $BIN must contain libglfw3.a and libraylib.a
    fpc -k-lpthread -k-lm -k-lz -k-lGL -k-lX11 -k-lXext -k-lXfixes -k-ldl -Fu$BIN -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP $pasfile
  else
    fpc -Fl$RAYLIB -Fl$LIBS -Fu$LIBS -FE$BIN -FU$TMP $pasfile
  fi
done
