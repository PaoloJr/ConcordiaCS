# main target in makfile
# primary entry point to build the project
# allows to run `make` without any arguments / options
all: dataConverterSub

# for creating the executable
# can add `@` symbol to suppress showing the command 
# ex: @ld -m elf_i386 -o dataConverterSub dataConverterSub.o
dataConverterSub: dataConverterSub.o
	ld -m elf_i386 -o dataConverterSub dataConverterSub.o

# for creating the object file
# can add `@` symbol to suppress showing the command 
# ex: @nasm -f elf32 -g -F dwarf dataConverterSub.asm -o dataConverterSub.o
dataConverterSub.o: dataConverterSub.asm
	nasm -f elf32 -g -F dwarf dataConverterSub.asm -o dataConverterSub.o

# run `make clean` to target the `clean` command
# suppress with `-s` option or with
# `@` symbol
# ex: @rm -f dataConverterSub.o dataConverterSub 
clean:
	rm -f dataConverterSub.o dataConverterSub

# special target tells `make` that `all` and `clean` are phony targets
# this says that the targets are not files and that they are used to group commands or dependencies
.PHONY: all clean