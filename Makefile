.PHONY: default clean Windows Darwin Linux

RAYLIB_LIBTYPE ?= SHARED

ifeq ($(OS),Windows_NT)
	TARGET_OS := Windows
else
	TARGET_OS := $(shell uname -s)	
endif

ifeq ($(RAYLIB_LIBTYPE),STATIC)
	BFLAGS = "--static"
endif
ifeq ($(RAYLIB_LIBTYPE),SHARED)
	BFLAGS = ""
endif

default: $(TARGET_OS) ;

clean:
	rm tmp/*.o tmp/*.ppu
Windows:
	build.bat
Darwin:
	sh build.macos.sh $(BFLAGS)
Linux:
	sh build.linux.sh $(BFLAGS)
