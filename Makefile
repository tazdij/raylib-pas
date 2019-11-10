ifeq ($(OS),Windows_NT)
	TARGET_OS := Windows
else
	TARGET_OS := $(shell uname -s)	
endif

all: $(TARGET_OS)

clean: $(TARGET_OS)_clean

Windows:
	build.bat
Darwin:
	sh build.macos.sh
Linux:
	sh build.linux.sh

Windows_clean:
	clean.bat
Darwin_clean:
	sh clean.macos.sh
Linux_clean:
	sh clean.linux.sh
