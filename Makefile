all: bin/fly.prg

bin/fly.prg: src/main.asm
	acme -v3 -f cbm -o bin/fly.bin src/main.asm
	./tools/pucrunch -x4096 bin/fly.bin bin/fly.prg

run: bin/fly.prg
	x64 bin/fly.prg

clean:
	rm bin/fly.bin
	rm bin/fly.prg
