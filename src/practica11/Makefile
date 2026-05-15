build:	 
	nasm -f elf p.asm
	ld -m elf_i386 p.o -o ../../bin/practica11.exe ../../lib/libpc_io.a
run:
	./../../bin/practica11.exe

build1:	 
	nasm -f elf pp.asm
	ld -m elf_i386 pp.o -o ../../bin/practica11.exe ../../lib/libpc_io.a
run1:
	./../../bin/practica11.exe

build2:	 
	nasm -f elf ppp.asm
	ld -m elf_i386 ppp.o -o ../../bin/practica11.exe ../../lib/libpc_io.a
run2:
	./../../bin/practica11.exe


build3:	 
	nasm -f elf pppp.asm
	ld -m elf_i386 pppp.o -o ../../bin/practica11.exe ../../lib/libpc_io.a
run3:
	./../../bin/practica11.exe


build4:	 
	nasm -f elf pppp5.asm
	ld -m elf_i386 pppp5.o -o ../../bin/practica11.exe ../../lib/libpc_io.a
run4:
	./../../bin/practica11.exe



build5:	 
	nasm -f elf pppp6.asm
	ld -m elf_i386 pppp6.o -o ../../bin/practica11.exe ../../lib/libpc_io.a
run5:
	./../../bin/practica11.exe


build6:	 
	nasm -f elf pppp7.asm
	ld -m elf_i386 pppp7.o -o ../../bin/practica11.exe ../../lib/libpc_io.a
run6:
	./../../bin/practica11.exe

build7: 
	gcc -m32 -c Main.c
	nasm -f elf pppp8.asm
	gcc -m32 pppp8.o Main.o -L ../../lib -lpc_io -no-pie -z noexecstack -o ../../bin/practica11.exe
run7:
	./../../bin/practica11.exe