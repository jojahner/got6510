SRC_DIR := src
SRC_FILES := $(wildcard $(SRC_DIR)/*.asm)

.DEFAULT_GOAL: build

.PHONY: build run debug clean

build: bin/got.prg

bin/got.prg: $(SRC_FILES)
	acme -v3 -f cbm --vicelabels bin/got.labels -o bin/got.prg src/main.asm
#	./tools/pucrunch -x4096 bin/got.bin bin/got.prg

run: build
	x64 bin/got.prg

debug: build
	~/Applications/C64Debugger.app/Contents/MacOS/C64Debugger -prg bin/got.prg -symbols bin/got.labels -breakpoints bin/breakpoints.txt

clean:
	rm -f bin/*.labels
	rm -f bin/*.bin
	rm -f bin/*.prg
