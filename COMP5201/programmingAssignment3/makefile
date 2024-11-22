ASM = nasm
ASM_FLAGS = -f elf64 -g -F dwarf
LD = ld
LD_FLAGS = -m elf_i386
MAIN_FILE = main.asm
EXT_SUBFILE = extSubPerfSquare.asm

# main target in makfile
# primary entry point to build the project
# allows to run `make` without any arguments / options
all: program

# for creating the executable
# can add `@` symbol to suppress showing the command 
# ex: @ld -m elf_i386 -o <ELF binary> <objectFile>.o
program: main.o extSubPerfSquare.o 
	$(LD) $(LD_FLAGS) -o program main.o extSubPerfSquare.o

# for creating the object file
# can add `@` symbol to suppress showing the command 
# ex: @nasm -f elf32 -g -F dwarf extSubPerfSquare.asm -o extSubPerfSquare.o
main.o: $(MAIN_FILE)
	$(ASM) $(ASM_FLAGS) $(MAIN_FILE) -o main.o

extSubPerfSquare.o: $(EXT_SUBFILE)
	$(ASM) $(ASM_FLAGS) $(EXT_SUBFILE) -o extSubPerfSquare.o


# run `make clean` to target the `clean` command
# suppress with `-s` option or with
# `@` symbol
# ex: @rm -f extSubPerfSquare.o extSubPerfSquare 
clean:
	rm -f program main.o extSubPerfSquare.o 

# special target tells `make` that `all` and `clean` are phony targets
# this says that the targets are not files and that they are used to group commands or dependencies
.PHONY: all clean