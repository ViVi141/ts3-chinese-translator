#
# Makefile to build TeamSpeak 3 Client Translator Plugin
# Works with MSYS2 MinGW64 and Linux
# GitHub: https://github.com/ViVi141/ts3-chinese-translator
# Author: ViVi141 (747384120@qq.com)
#

# Detect OS
ifeq ($(OS),Windows_NT)
    PLATFORM = WINDOWS
    EXT = .dll
    CFLAGS = -c -O2 -Wall
    LDFLAGS = -shared -lwinhttp
    CC = gcc
else
    # Check if we're in MSYS2 environment
    ifneq ($(MSYSTEM),)
        PLATFORM = MSYS2
        EXT = .dll
        CFLAGS = -c -O2 -Wall
        LDFLAGS = -shared -lwinhttp
        CC = gcc
    else
        PLATFORM = LINUX
        EXT = .so
        CFLAGS = -c -O2 -Wall -fPIC
        LDFLAGS = -shared
        CC = gcc
    endif
endif

PLUGIN_NAME = ts3_translator_plugin$(EXT)
DIST_DIR = dist

all: $(DIST_DIR)/$(PLUGIN_NAME)

$(DIST_DIR)/$(PLUGIN_NAME): plugin.o | $(DIST_DIR)
	$(CC) -o $(DIST_DIR)/$(PLUGIN_NAME) plugin.o $(LDFLAGS)

plugin.o: ./src/plugin.c
	$(CC) -Iinclude src/plugin.c $(CFLAGS)

$(DIST_DIR):
	mkdir -p $(DIST_DIR)

clean:
	rm -rf *.o $(DIST_DIR)/$(PLUGIN_NAME) test_plugin.so test_plugin.dll

.PHONY: all clean
