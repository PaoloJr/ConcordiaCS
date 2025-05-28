# main target in makfile
# primary entry point to build the project
# allows to run `make` without any arguments / options

all: dataConverter

# for creating the executable
# can add `@` symbol to suppress showing the command 
# ex: @ld -m elf_i386 -o dataConverter dataConverter.o
dataConverter: dataConverter.o
	ld -m elf_i386 -o dataConverter dataConverter.o

# for creating the object file
# can add `@` symbol to suppress showing the command 
# ex: @nasm -f elf32 -g -F dwarf dataConverter.asm -o dataConverter.o
dataConverter.o: dataConverter.asm
	nasm -f elf32 -g -F dwarf dataConverter.asm -o dataConverter.o

# run `make clean` to target the `clean` command
# suppress with `-s` option or with
# `@` symbol
# ex: @rm -f dataConverter.o dataConverter 
clean:
	rm -f dataConverter.o dataConverter

# special target tells `make` that `all` and `clean` are phony targets
# this says that the targets are not files and that they are used to group commands or dependencies
.PHONY: all clean