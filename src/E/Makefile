

build: 
	gcc -m32 -c Main.c
	nasm -f elf p.asm
	gcc -m32 p.o Main.o -L ../../lib -lpc_io -no-pie -z noexecstack -o ../../bin/E.exe
run:
	./../../bin/E.exe

	