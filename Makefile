all: bin/got.prg

bin/got.prg: src/main.asm src/macros.asm
	acme -v3 -f cbm -vl bin/got.labels -o bin/got.bin src/main.asm
	./tools/pucrunch -x4096 bin/got.bin bin/got.prg

run: bin/got.prg
	x64 bin/got.prg

debug: bin/got.prg
	~/Applications/C64Debugger.app/Contents/MacOS/C64Debugger -prg bin/got.prg -symbols bin/got.labels -breakpoints bin/breakpoints.txt

clean:
	rm bin/*.labels
	rm bin/*.bin
	rm bin/*.prg
