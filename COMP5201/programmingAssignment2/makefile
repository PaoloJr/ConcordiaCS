# main target in makfile
# primary entry point to build the project
# allows to run `make` without any arguments / options
all: subDataConverter

# for creating the executable
# can add `@` symbol to suppress showing the command 
# ex: @ld -m elf_i386 -o <ELF binary> <objectFile>.o
subDataConverter: subDataConverter.o
	ld -m elf_i386 -o subDataConverter subDataConverter.o

# for creating the object file
# can add `@` symbol to suppress showing the command 
# ex: @nasm -f elf32 -g -F dwarf subDataConverter.asm -o subDataConverter.o
subDataConverter.o: subDataConverter.asm
	nasm -f elf32 -g -F dwarf subDataConverter.asm -o subDataConverter.o

# run `make clean` to target the `clean` command
# suppress with `-s` option or with
# `@` symbol
# ex: @rm -f subDataConverter.o subDataConverter 
clean:
	rm -f subDataConverter.o subDataConverter

# special target tells `make` that `all` and `clean` are phony targets
# this says that the targets are not files and that they are used to group commands or dependencies
.PHONY: all clean